From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 05:00:34 +0900
Subject: [GIT PULL 06/10] Samsung non-DT EXYNOS for v3.11
Message-ID: <51C0BC62.3000605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Probably happens merge conflicts :(
Note, following is my resolution for it.

If any problems, please kindly let me know.

Thanks,
- Kukjin

Conflicts:
     	arch/arm/Kconfig
     	arch/arm/mach-exynos/Kconfig

diff --cc arch/arm/Kconfig
index 7f6dff7,14f6e11..ddf2667
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -745,7 -749,7 +750,8 @@@ config ARCH_S5P64X
   	select HAVE_S3C2410_WATCHDOG if WATCHDOG
   	select HAVE_S3C_RTC if RTC_CLASS
   	select NEED_MACH_GPIO_H
+ 	select SAMSUNG_ATAGS
  +	select SAMSUNG_WDT_RESET
   	help
   	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
   	  SMDK6450.
@@@ -762,7 -767,7 +769,8 @@@ config ARCH_S5PC10
   	select HAVE_S3C2410_WATCHDOG if WATCHDOG
   	select HAVE_S3C_RTC if RTC_CLASS
   	select NEED_MACH_GPIO_H
+ 	select SAMSUNG_ATAGS
  +	select SAMSUNG_WDT_RESET
   	help
   	  Samsung S5PC100 series based systems

diff --cc arch/arm/mach-exynos/Kconfig
index e51d990,46c8332..1e0e399
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@@ -418,8 -96,9 +101,7 @@@ config MACH_EXYNOS4_D
   	select CLKSRC_SAMSUNG_PWM if CPU_EXYNOS4210
   	select CPU_EXYNOS4210
   	select KEYBOARD_SAMSUNG if INPUT_KEYBOARD
  -	select PINCTRL
  -	select PINCTRL_EXYNOS
   	select S5P_DEV_MFC
- 	select USE_OF
   	help
   	  Machine support for Samsung Exynos4 machine with device tree enabled.
   	  Select this if a fdt blob is available for the Exynos4 SoC based 
board.
@@@ -432,8 -111,6 +114,7 @@@ config MACH_EXYNOS5_D
   	depends on ARCH_EXYNOS5
   	select ARM_AMBA
   	select CLKSRC_OF
  +	select USB_ARCH_HAS_XHCI
- 	select USE_OF
   	help
   	  Machine support for Samsung EXYNOS5 machine with device tree enabled.
   	  Select this if a fdt blob is available for the EXYNOS5 SoC based 
board.

----

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

   Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/remove-nondt-exynos-3

for you to fetch changes up to 564d06b1266ee62c9b47eab8305755e5ff6e38d5:

   ARM: EXYNOS: Remove remaining dead code after non-DT support removal 
(2013-06-19 01:37:53 +0900)

----------------------------------------------------------------
cleanup and removing dead code for only support DT for exynos
- remove board file for exynos
- remove legacy files which are not used anymore
- decouple ARCH_EXYNOS from PLAT_S5P

----------------------------------------------------------------
Arnd Bergmann (4):
       ARM: EXYNOS: Remove custom init_irq callbacks
       ARM: EXYNOS: Use exynos_init_io() as map_io callback
       ARM: EXYNOS: Remove legacy L2X0 initialization
       ARM: EXYNOS: Remove remaining dead code after non-DT support removal

Kukjin Kim (1):
       ARM: EXYNOS: no more support non-DT for EXYNOS SoCs

Tomasz Figa (30):
       ARM: EXYNOS: Remove unused board files
       ARM: EXYNOS: Make ARCH_EXYNOS select USE_OF
       ARM: SAMSUNG: Introduce SAMSUNG_ATAGS Kconfig entry
       ARM: EXYNOS: Remove legacy PMU initialization code
       ARM: EXYNOS: Remove legacy EINT initialization code
       ARM: EXYNOS: Remove legacy UART initialization code
       ARM: EXYNOS: Remove legacy dev- and setup- files
       ARM: EXYNOS: Remove legacy interrupt initialization code
       ARM: EXYNOS: Remove legacy timer initialization code
       ARM: EXYNOS: Remove platform device initialization
       ARM: EXYNOS: Remove legacy mapping of chip ID block
       ARM: EXYNOS: Remove check for device tree presence
       ARM: EXYNOS: Remove legacy power domain registration code
       ARM: SAMSUNG: Introduce GPIO_SAMSUNG Kconfig entry
       ARM: EXYNOS: Provide compatibility stubs for PM code in pm-core.h 
header
       ARM: SAMSUNG: Compile legacy IRQ and GPIO PM code only with ATAGS 
support
       platform: Check for ARCH_EXYNOS separately
       USB: Check for ARCH_EXYNOS separately
       ARM: EXYNOS: Decouple ARCH_EXYNOS from PLAT_S5P
       ARM: SAMSUNG: Include most of mach/ headers conditionally
       ARM: EXYNOS: Do not select legacy Kconfig symbols any more
       ARM: EXYNOS: Remove setup-i2c0.c
       ARM: EXYNOS: Remove mach/gpio.h
       ARM: EXYNOS: Remove mach/regs-gpio.h header
       ARM: SAMSUNG: Make legacy MFC support code depend on SAMSUNG_ATAGS
       ARM: EXYNOS: Select SPARSE_IRQ for Exynos
       ARM: EXYNOS: Remove mach/irqs.h header
       ARM: EXYNOS: Remove unused base addresses from mach/map.h header
       thermal: exynos: Support both EXYNOS4X12 SoCs
       ARM: EXYNOS: Remove mach/regs-usb-phy.h header

  arch/arm/Kconfig                                 |   15 +-
  arch/arm/Makefile                                |    1 +
  arch/arm/mach-exynos/Kconfig                     |  340 +-----
  arch/arm/mach-exynos/Makefile                    |   33 -
  arch/arm/mach-exynos/common.c                    |  547 +--------
  arch/arm/mach-exynos/common.h                    |    4 +-
  arch/arm/mach-exynos/dev-ahci.c                  |  255 ----
  arch/arm/mach-exynos/dev-audio.c                 |  254 ----
  arch/arm/mach-exynos/dev-ohci.c                  |   52 -
  arch/arm/mach-exynos/dev-uart.c                  |   55 -
  arch/arm/mach-exynos/dma.c                       |  322 -----
  arch/arm/mach-exynos/firmware.c                  |   22 +-
  arch/arm/mach-exynos/include/mach/gpio.h         |  289 -----
  arch/arm/mach-exynos/include/mach/irqs.h         |  476 --------
  arch/arm/mach-exynos/include/mach/map.h          |  214 ----
  arch/arm/mach-exynos/include/mach/pm-core.h      |   12 +-
  arch/arm/mach-exynos/include/mach/regs-gpio.h    |   40 -
  arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   74 --
  arch/arm/mach-exynos/mach-armlex4210.c           |  207 ----
  arch/arm/mach-exynos/mach-exynos4-dt.c           |    8 +-
  arch/arm/mach-exynos/mach-exynos5-dt.c           |    8 +-
  arch/arm/mach-exynos/mach-nuri.c                 | 1388 
----------------------
  arch/arm/mach-exynos/mach-origen.c               |  823 -------------
  arch/arm/mach-exynos/mach-smdk4x12.c             |  396 ------
  arch/arm/mach-exynos/mach-smdkv310.c             |  444 -------
  arch/arm/mach-exynos/mach-universal_c210.c       | 1159 ------------------
  arch/arm/mach-exynos/pm.c                        |    1 -
  arch/arm/mach-exynos/pm_domains.c                |  101 +-
  arch/arm/mach-exynos/setup-fimc.c                |   44 -
  arch/arm/mach-exynos/setup-fimd0.c               |   43 -
  arch/arm/mach-exynos/setup-i2c0.c                |   29 -
  arch/arm/mach-exynos/setup-i2c1.c                |   23 -
  arch/arm/mach-exynos/setup-i2c2.c                |   23 -
  arch/arm/mach-exynos/setup-i2c3.c                |   23 -
  arch/arm/mach-exynos/setup-i2c4.c                |   23 -
  arch/arm/mach-exynos/setup-i2c5.c                |   23 -
  arch/arm/mach-exynos/setup-i2c6.c                |   23 -
  arch/arm/mach-exynos/setup-i2c7.c                |   23 -
  arch/arm/mach-exynos/setup-keypad.c              |   36 -
  arch/arm/mach-exynos/setup-sdhci-gpio.c          |  152 ---
  arch/arm/mach-exynos/setup-spi.c                 |   45 -
  arch/arm/mach-exynos/setup-usb-phy.c             |  223 ----
  arch/arm/plat-samsung/Kconfig                    |   47 +-
  arch/arm/plat-samsung/Makefile                   |   11 +-
  arch/arm/plat-samsung/include/plat/pm.h          |    5 +
  arch/arm/plat-samsung/init.c                     |    8 +-
  arch/arm/plat-samsung/pm-gpio.c                  |    5 +-
  arch/arm/plat-samsung/pm.c                       |    8 +-
  arch/arm/plat-samsung/s5p-dev-mfc.c              |   11 +-
  drivers/gpio/Kconfig                             |    7 +
  drivers/gpio/Makefile                            |    2 +-
  drivers/media/platform/Kconfig                   |    6 +-
  drivers/media/platform/exynos4-is/Kconfig        |    3 +-
  drivers/media/platform/s5p-tv/Kconfig            |    2 +-
  drivers/thermal/exynos_thermal.c                 |    3 +-
  drivers/usb/Kconfig                              |    1 +
  drivers/usb/host/Kconfig                         |    2 +-
  57 files changed, 136 insertions(+), 8258 deletions(-)
  delete mode 100644 arch/arm/mach-exynos/dev-ahci.c
  delete mode 100644 arch/arm/mach-exynos/dev-audio.c
  delete mode 100644 arch/arm/mach-exynos/dev-ohci.c
  delete mode 100644 arch/arm/mach-exynos/dev-uart.c
  delete mode 100644 arch/arm/mach-exynos/dma.c
  delete mode 100644 arch/arm/mach-exynos/include/mach/gpio.h
  delete mode 100644 arch/arm/mach-exynos/include/mach/irqs.h
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-gpio.h
  delete mode 100644 arch/arm/mach-exynos/include/mach/regs-usb-phy.h
  delete mode 100644 arch/arm/mach-exynos/mach-armlex4210.c
  delete mode 100644 arch/arm/mach-exynos/mach-nuri.c
  delete mode 100644 arch/arm/mach-exynos/mach-origen.c
  delete mode 100644 arch/arm/mach-exynos/mach-smdk4x12.c
  delete mode 100644 arch/arm/mach-exynos/mach-smdkv310.c
  delete mode 100644 arch/arm/mach-exynos/mach-universal_c210.c
  delete mode 100644 arch/arm/mach-exynos/setup-fimc.c
  delete mode 100644 arch/arm/mach-exynos/setup-fimd0.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c0.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c1.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c2.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c3.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c4.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c5.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c6.c
  delete mode 100644 arch/arm/mach-exynos/setup-i2c7.c
  delete mode 100644 arch/arm/mach-exynos/setup-keypad.c
  delete mode 100644 arch/arm/mach-exynos/setup-sdhci-gpio.c
  delete mode 100644 arch/arm/mach-exynos/setup-spi.c
  delete mode 100644 arch/arm/mach-exynos/setup-usb-phy.c
