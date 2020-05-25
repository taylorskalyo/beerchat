#!/bin/sh
# simple integration test

CFG=/tmp/minetest.conf
MTDIR=/tmp/mt
WORLDDIR=${MTDIR}/worlds/world

cat <<EOF > ${CFG}
 enable_beerchat_integration_test = true
 secure.http_mods = beerchat
EOF

mkdir -p ${WORLDDIR}
chmod 777 ${MTDIR} -R
docker run --rm -i \
	-v ${CFG}:/etc/minetest/minetest.conf:ro \
	-v ${MTDIR}:/var/lib/minetest/.minetest \
	-v $(pwd):/var/lib/minetest/.minetest/worlds/world/worldmods/beerchat \
	registry.gitlab.com/minetest/minetest/server:5.2.0

test -f ${WORLDDIR}/integration_test.json && exit 0 || exit 1
