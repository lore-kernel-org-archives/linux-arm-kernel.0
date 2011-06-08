From: zhangfei.gao@marvell.com (Zhangfei Gao)
Date: Wed,  8 Jun 2011 17:41:56 +0800
Subject: [PATCH v4 0/5] Provide sdhci driver for mmp2 and pxa9xx
Message-ID: <1307526121-12059-1-git-send-email-zhangfei.gao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v3->v4
Update patch sequence and mmp2_defconfig
update driver/mmc/host/Kconfig
Remove get_ro

The patches to provide separate sdhci driver for mmp2 and pxa910
based on sdhci-platfm.
Rename to sdhci-pxav3.c and sdhci-pxav2.c
Remove obsolete sdhci-pxa.c, which is used to share among pxa serious, since
under this method, platform difference have to be put under arch/arm,
which is not easy to track.
As a result, mmp2 mmc resource should be updated accordingly.

Zhangfei Gao (5):
  mmc: support sdhci-pxav3.c
  mmc: support sdhci-pxav2.c
  ARM: mmp2: update mmp2 mmc resource
  mmc: delete obsolete sdhci-pxa.c
  ARM: mmp2: update mmp2_defconfig to support mmc

 arch/arm/configs/mmp2_defconfig        |    9 +-
 arch/arm/mach-mmp/brownstone.c         |   10 +-
 arch/arm/mach-mmp/jasper.c             |    2 +-
 arch/arm/mach-mmp/mmp2.c               |   16 +-
 arch/arm/plat-pxa/include/plat/sdhci.h |   35 +++-
 drivers/mmc/host/Kconfig               |   24 ++-
 drivers/mmc/host/Makefile              |    3 +-
 drivers/mmc/host/sdhci-pxa.c           |  303 --------------------------------
 drivers/mmc/host/sdhci-pxav2.c         |  244 +++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pxav3.c         |  289 ++++++++++++++++++++++++++++++
 10 files changed, 609 insertions(+), 326 deletions(-)
 delete mode 100644 drivers/mmc/host/sdhci-pxa.c
 create mode 100644 drivers/mmc/host/sdhci-pxav2.c
 create mode 100644 drivers/mmc/host/sdhci-pxav3.c
