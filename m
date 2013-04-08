From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 09 Apr 2013 03:17:51 +0900
Subject: [GIT PULL 01/10] cleanup-samsung for v3.10
Message-ID: <516309CF.6030202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a937538b868b8369b98967929045f1df54234323:

   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/cleanup-samsung-for-v3.10

for you to fetch changes up to fe72e27368265a99f6a0a189a5d593aac320a59d:

   ARM: EXYNOS: remove "config EXYNOS_DEV_DRM" (2013-04-09 00:32:38 +0900)

----------------------------------------------------------------
cleanup unused codes for samsung

----------------------------------------------------------------
Alexander Shiyan (3):
       ARM: S3C24XX: Removed unneeded dependency on ARCH_S3C24XX for boards
       ARM: S3C24XX: Removed unneeded dependency on CPU_S3C2410
       ARM: S3C24XX: Removed unneeded dependency on CPU_S3C2412

Jingoo Han (1):
       ARM: EXYNOS: change the name of USB ohci header

Padmavathi Venna (1):
       ARM: SAMSUNG: Remove unnecessary code for dma

Paul Bolle (11):
       ARM: S3C24XX: drop "select MACH_N35"
       ARM: S3C24XX: drop "select MACH_NEO1973"
       ARM: EXYNOS: drop "select HAVE_SCHED_CLOCK"
       ARM: EXYNOS: change HAVE_SAMSUNG_KEYPAD to KEYBOARD_SAMSUNG
       ARM: SAMSUNG: remove "config S3C_BOOT_WATCHDOG"
       ARM: SAMSUNG: Remove useless Samsung GPIO related CONFIG
       ARM: S3C24XX: remove unneeded "config SMDK2440_CPU2442"
       ARM: S3C64XX: remove obsolete Makefile line
       ARM: S5P64X0: Fix typo "CONFIG_S5P64X0_SETUP_SDHCI"
       ARM: SAMSUNG: Fix typo "CONFIG_SAMSUNG_DEV_RTC"
       ARM: EXYNOS: remove "config EXYNOS_DEV_DRM"

Sylwester Nawrocki (1):
       ARM: S3C24XX: Remove unused GPIO drive strength register definitions

Wei Yongjun (1):
       ARM: EXYNOS: remove duplicated include from common.c

  arch/arm/Kconfig                                   |   1 -
  arch/arm/mach-exynos/Kconfig                       |  13 +-
  arch/arm/mach-exynos/common.c                      |   1 -
  arch/arm/mach-exynos/dev-ohci.c                    |   2 +-
  arch/arm/mach-exynos/mach-origen.c                 |   2 +-
  arch/arm/mach-exynos/mach-smdkv310.c               |   2 +-
  arch/arm/mach-s3c24xx/Kconfig                      |  22 +--
  arch/arm/mach-s3c24xx/include/mach/dma.h           |   1 -
  arch/arm/mach-s3c24xx/regs-dsc.h                   | 203 
+--------------------
  arch/arm/mach-s3c64xx/Makefile                     |   1 -
  arch/arm/mach-s3c64xx/include/mach/dma.h           |   1 -
  arch/arm/plat-samsung/Kconfig                      |  14 --
  arch/arm/plat-samsung/dma-ops.c                    |  10 +-
  arch/arm/plat-samsung/include/plat/dma-ops.h       |   1 -
  arch/arm/plat-samsung/include/plat/dma-pl330.h     |   1 -
  arch/arm/plat-samsung/include/plat/rtc-core.h      |   2 +-
  arch/arm/plat-samsung/include/plat/sdhci.h         |   4 +-
  drivers/usb/host/ohci-exynos.c                     |   3 +-
  .../{usb-exynos.h => usb-ohci-exynos.h}            |   0
  19 files changed, 20 insertions(+), 264 deletions(-)
  rename include/linux/platform_data/{usb-exynos.h => usb-ohci-exynos.h} 
(100%)
-- 
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
