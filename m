From: s-anna@ti.com (Suman Anna)
Date: Thu, 18 May 2017 17:08:58 -0500
Subject: [PATCH 0/4] Davinci remoteproc cleanups/fixes
Message-ID: <20170518220902.2846-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bjorn,

The following series includes various fixes and cleanups for the TI's
Davinci DSP remoteproc driver. Patches are based on 4.12-rc1. Following
is the patch summary:

 - Patch1 updates/fixes the build dependency on DMA_CMA which is not
   selected by default in the davinci_defconfig.
 - Patch 3 fixes a DSP boot/functionality issue with repeated 'start'
   and 'stop' commands using the sysfs 'state' variable.
 - Patch 2 and 4 are cleanups/code simplifications.

regards
Suman

Suman Anna (4):
  remoteproc/davinci: Update Kconfig to depend on DMA_CMA
  remoteproc/davinci: simplify the reset function
  remoteproc/davinci: fix unbalanced reset between start and stop ops
  remoteproc/davinci: streamline the interrupt management

 drivers/remoteproc/Kconfig            |  2 +-
 drivers/remoteproc/da8xx_remoteproc.c | 60 ++++++++---------------------------
 2 files changed, 15 insertions(+), 47 deletions(-)

-- 
2.12.0
