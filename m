From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Wed, 29 Nov 2017 11:27:16 +0100
Subject: [GIT PULL] tee async tee supplicant communication for v4.16
Message-ID: <20171129102715.dsxcsq6s5tvnep2s@jax>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc maintainers,

Please pull these tee driver changes. This implements support for
asynchronous communication with TEE supplicant. This isn't a bugfix so
I'm aiming for the next merge window.

Thanks,
Jens

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-async-supplicant-for-v4.16

for you to fetch changes up to 1647a5ac175490d7dac2e74532e85b6197fc74e9:

  optee: support asynchronous supplicant requests (2017-11-29 10:37:13 +0100)

----------------------------------------------------------------
Enable async communication with tee supplicant

This pull request enables asynchronous communication with TEE supplicant
by introducing meta parameters in the user space API. The meta
parameters can be used to tag requests with an id that can be matched
against an asynchronous response as is done here in the OP-TEE driver.

Asynchronous supplicant communication is needed by OP-TEE to implement
GlobalPlatforms TEE Sockets API Specification v1.0.1. The specification
is available at https://www.globalplatform.org/specificationsdevice.asp.

This change is backwards compatible allowing older supplicants to work
with newer kernels and vice versa.

----------------------------------------------------------------
Jens Wiklander (3):
      tee: add tee_param_is_memref() for driver use
      tee: add TEE_IOCTL_PARAM_ATTR_META
      optee: support asynchronous supplicant requests

 drivers/tee/optee/core.c          |  11 +-
 drivers/tee/optee/optee_private.h |  43 ++---
 drivers/tee/optee/rpc.c           |   4 +-
 drivers/tee/optee/supp.c          | 375 ++++++++++++++++++++++++--------------
 drivers/tee/tee_core.c            |  32 ++--
 include/linux/tee_drv.h           |  12 ++
 include/uapi/linux/tee.h          |   7 +
 7 files changed, 295 insertions(+), 189 deletions(-)
