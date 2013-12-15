From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 05:21:34 +0900
Subject: [GIT PULL 2/7] Samsung cleanup for v3.14
Message-ID: <52AE0F4E.5070309@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-cleanup

for you to fetch changes up to 7c394e7be4d267c02eaaac8fa197a7c1b023c99b:

   ARM: EXYNOS: Constify clksrc immutable register restore tables 
(2013-12-12 07:09:33 +0900)

----------------------------------------------------------------
Samsung cleanup for v3.14
- remove unused SAMSUNG_GPIOLIB_4BIT and IRQF_DISABLED
- constify immutable PMU data table and PM clksrc register
- make const struct for sleep_save

----------------------------------------------------------------
Daniel Kurtz (3):
       ARM: EXYNOS: Constify data tables for pmu
       ARM: SAMSUNG: Let s3c_pm_do_restore_*() take const sleep_save
       ARM: EXYNOS: Constify clksrc immutable register restore tables

Michael Opdenacker (2):
       ARM: SAMSUNG: remove unused SAMSUNG_GPIOLIB_4BIT Kconfig parameter
       ARM: SAMSUNG: remove IRQF_DISABLED

  arch/arm/Kconfig                        |  1 -
  arch/arm/mach-exynos/pm.c               |  4 ++--
  arch/arm/mach-exynos/pmu.c              | 14 +++++++-------
  arch/arm/mach-s3c24xx/dma.c             |  2 +-
  arch/arm/mach-s3c24xx/simtec-usb.c      |  3 +--
  arch/arm/mach-s3c64xx/mach-smartq.c     |  2 +-
  arch/arm/plat-samsung/Kconfig           |  8 --------
  arch/arm/plat-samsung/include/plat/pm.h |  4 ++--
  arch/arm/plat-samsung/pm.c              |  4 ++--
  9 files changed, 16 insertions(+), 26 deletions(-)
