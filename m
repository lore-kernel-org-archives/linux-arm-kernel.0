From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Thu, 28 Dec 2017 16:38:55 +0100
Subject: [PATCH 0/2] Fix tee: optee: add dynamic shared memory support
Message-ID: <20171228153857.30086-1-jens.wiklander@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These two patches complements the previously posted patchset
"tee: optee: add dynamic shared memory support"
https://lwn.net/Articles/740242/

Tests are added to see that the registered shared memory cache attributes
are compatible with OP-TEE in secure world. Under normal circumstances they
will be compatible, but if memory has been previously mapped from a device
with special page attributes it could lead to trouble.

Thanks,
Jens

Jens Wiklander (2):
  tee: add start argument to shm_register callback
  tee: optee: check type of registered shared memory

 drivers/tee/optee/call.c          | 50 +++++++++++++++++++++++++++++++++++----
 drivers/tee/optee/optee_private.h |  6 +++--
 drivers/tee/tee_shm.c             |  2 +-
 include/linux/tee_drv.h           |  3 ++-
 4 files changed, 53 insertions(+), 8 deletions(-)

-- 
2.14.1
