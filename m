From: jens.wiklander@linaro.org (Jens Wiklander)
Date: Mon, 2 Jul 2018 14:10:13 +0200
Subject: [GIT PULL] tee driver for v4.18
Message-ID: <20180702121013.GA17791@jax.urgonet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello arm-soc maintainers,

Please pull these small tee driver enhancements. There's a new config
option for the OP-TEE driver, OPTEE_SHM_NUM_PRIV_PAGES. Also the OP-TEE
driver reads current time with ktime_get_real_ts64() from now on.

Thanks,
Jens

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-drv-for-4.18

for you to fetch changes up to 3249527f19d660c5adfb2b6f4ffd4ca0506b8755:

  tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig (2018-06-20 11:20:36 +0200)

----------------------------------------------------------------
Misc enhancement for tee driver subsystem

* Replaces getnstimeofday64() with ktime_get_real_ts64()
* Adds OPTEE_SHM_NUM_PRIV_PAGES to configure how many pages should be
  statically reserved for driver private allocations

----------------------------------------------------------------
Arnd Bergmann (1):
      tee: replace getnstimeofday64() with ktime_get_real_ts64()

Sahil Malhotra (1):
      tee: optee: making OPTEE_SHM_NUM_PRIV_PAGES configurable via Kconfig

 drivers/tee/optee/Kconfig | 8 ++++++++
 drivers/tee/optee/core.c  | 2 +-
 drivers/tee/optee/rpc.c   | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)
