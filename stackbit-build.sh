#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://5835ea77.ngrok.io/project/5dc8dc313c0b9a8c3eafcbfc/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://5835ea77.ngrok.io/pull/5dc8dc313c0b9a8c3eafcbfc 
fi
curl -s -X POST https://5835ea77.ngrok.io/project/5dc8dc313c0b9a8c3eafcbfc/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://5835ea77.ngrok.io/project/5dc8dc313c0b9a8c3eafcbfc/webhook/build/publish > /dev/null
