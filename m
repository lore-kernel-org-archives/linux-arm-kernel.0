From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  5 May 2016 14:29:38 +0100
Subject: [PATCH 0/5] remoteproc: A few important improvements
Message-ID: <1462454983-13168-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This set contains some extensions which allow greater interoperability
with other heavily used subsystems/booting mechanisms already in the
kernel.  This includes; Device Tree (OF) support, fix possible race
between remoteproc and rpmsg/virtio, remotely (from a client) set the
firmware name, introduction of a nice way to handle shared (between
subsystems) memory and automatic carveout clipping.

Lee Jones (5):
  remoteproc: core: Task sync during rproc_fw_boot()
  remoteproc: core: Add rproc OF look-up functions
  remoteproc: core: Add ability to select a firmware from the client
  remoteproc: core: Supply framework to request, declare and fetch
    shared memory
  remoteproc: core: Clip carveout if it's too big

 drivers/remoteproc/remoteproc_core.c     | 371 ++++++++++++++++++++++++++++++-
 drivers/remoteproc/remoteproc_internal.h |   1 +
 drivers/remoteproc/remoteproc_virtio.c   |   2 +-
 include/linux/remoteproc.h               |  16 ++
 4 files changed, 379 insertions(+), 11 deletions(-)

-- 
2.8.0
