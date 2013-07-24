From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 25 Jul 2013 02:00:37 +0900
Subject: [GIT PULL] Samsung-fixes-1 for v3.11
Message-ID: <51F00835.9040202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-fixes-1

for you to fetch changes up to 53302bf60d2c95ee42118008499a5f5de544fcc1:

   ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos (2013-07-24 
18:55:27 +0900)

----------------------------------------------------------------
Samsung fixes for v3.11
- fix kernel booting on exynos5440
   skip pm which is not supported
   update regarding LPAE features
- fix s3c2440 uart with adding clkdev entries
- fix compilatioin for Samsung SoCs with selecting pm
- update ARCH_NR_GPIO to support exynos4412 has more gpios

----------------------------------------------------------------
Amit Daniel Kachhap (1):
       ARM: SAMSUNG: Add SAMSUNG_PM config option to select pm

Kukjin Kim (1):
       ARM: EXYNOS: skip pm support on exynos5440

Sachin Kamat (1):
       ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos

Subash Patel (1):
       ARM: EXYNOS: change the PHYSMEM_BITS and SECTION_SIZE

Sylwester Nawrocki (1):
       ARM: S3C24XX: Add missing clkdev entries for s3c2440 UART

Thomas Abraham (1):
       ARM: EXYNOS: Enable 64-bit DMA for EXYNOS5440 if LPAE is enabled

Yadwinder Singh Brar (2):
       ARM: SAMSUNG: Save/restore only selected uart's registers
       ARM: EXYNOS: Fix low level debug support

  arch/arm/Kconfig                           |   3 +-
  arch/arm/mach-exynos/Kconfig               |   1 +
  arch/arm/mach-exynos/Makefile              |   2 +-
  arch/arm/mach-exynos/common.c              |  26 -----
  arch/arm/mach-exynos/common.h              |   1 -
  arch/arm/mach-exynos/cpuidle.c             |   1 +
  arch/arm/mach-exynos/include/mach/memory.h |   5 +
  arch/arm/mach-exynos/pm.c                  |   6 ++
  arch/arm/mach-s3c24xx/clock-s3c2410.c      | 161 
++++++++++++++++++-----------
  arch/arm/mach-s3c24xx/clock-s3c2440.c      |   3 +
  arch/arm/plat-samsung/Kconfig              |   7 ++
  arch/arm/plat-samsung/Makefile             |   2 +-
  arch/arm/plat-samsung/include/plat/clock.h |   5 +
  arch/arm/plat-samsung/include/plat/pm.h    |   8 +-
  arch/arm/plat-samsung/pm.c                 |  14 +--
  15 files changed, 136 insertions(+), 109 deletions(-)
