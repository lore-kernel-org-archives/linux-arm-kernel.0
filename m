From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 26 Aug 2011 10:25:58 +0200
Subject: [GIT PULL] i.MX cleanups for next
In-Reply-To: <20110823115609.GJ31404@pengutronix.de>
References: <20110823115609.GJ31404@pengutronix.de>
Message-ID: <20110826082558.GC7526@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Since you haven't pulled this yet, here is an update:


The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git imx-cleanups-for-arnd

Fabio Estevam (2):
      ARM: mx50: Select IMX_HAVE_PLATFORM_FEC as done on other i.MX devices
      ARM: mxs: Remove unused header file

Jason Liu (1):
      imx5: not include the unused head file

Sascha Hauer (4):
      Merge branch 'imx-cleanup' of git://git.pengutronix.de/git/ukl/linux-2.6 into imx-cleanup
      ARM i.MX audmux v2: remove unnecessary ifdefs
      ARM i.MX: remove ARCH_MX* macros from Makefile
      Merge branches 'cleanups/assorted', 'cleanups/shawn-cleanup-mxc-gpio', 'cleanups/troy-cleanup-iomux-v3' and 'cleanups/ukl-mx5-dynamically-allocate-devices' into imx-cleanups-for-arnd

Shawn Guo (7):
      arm/mxc: do not use gpio_to_irq() for static initializers
      gpio/mxc: add .to_irq for gpio chip
      arm/mxc: use gpiolib helper for gpio_to_irq
      gpio/mxc: move irq_to_gpio() into gpio-mxc driver
      arm/mxc: move IMX_GPIO_NR into mach/hardware.h
      gpio/mxs: move irq_to_gpio() into gpio-mxs driver
      arm/mxs: move MXS_GPIO_NR into mach/mxs.h

Troy Kisky (3):
      ARM: i.MX51: Remove _MX51_PAD_xxx references
      ARM: i.MX51: clean up iomux-mx51.h
      ARM: i.MX53: clean up iomux-mx53.h

Uwe Kleine-K?nig (8):
      ARM: mx5: fix remaining inconsistent names for irqs
      ARM: mx5: remove unused #includes of devices.h
      ARM: mx5: dynamically allocate mxc-ehci devices
      ARM: mx5: dynamically allocate fsl-usb2-udc devices
      ARM: mx5: dynamically allocate high speed i2c (imx-i2c actually)
      ARM: imx/mx1ads: dynamically allocate physmap-flash device
      ARM: imx/armadillo5x0: dynamically allocate physmap-flash device
      ARM: mxc: drop now unused function mxc_register_device

 arch/arm/mach-imx/Makefile                        |   10 +-
 arch/arm/mach-imx/mach-armadillo5x0.c             |   18 +-
 arch/arm/mach-imx/mach-cpuimx35.c                 |    2 +-
 arch/arm/mach-imx/mach-mx1ads.c                   |   15 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                 |    2 +-
 arch/arm/mach-imx/mach-vpr200.c                   |    2 +-
 arch/arm/mach-mx5/Kconfig                         |   10 +-
 arch/arm/mach-mx5/Makefile                        |    2 +-
 arch/arm/mach-mx5/board-cpuimx51.c                |   27 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c              |   25 +-
 arch/arm/mach-mx5/board-mx51_3ds.c                |    1 -
 arch/arm/mach-mx5/board-mx51_babbage.c            |   26 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c            |    2 -
 arch/arm/mach-mx5/board-mx51_efikasb.c            |    6 +-
 arch/arm/mach-mx5/board-mx53_ard.c                |    4 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c               |    2 +-
 arch/arm/mach-mx5/devices-imx51.h                 |   13 +
 arch/arm/mach-mx5/devices.c                       |  120 -
 arch/arm/mach-mx5/devices.h                       |    5 -
 arch/arm/mach-mx5/ehci.c                          |    2 +-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c      |    3 +-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c      |    6 +-
 arch/arm/mach-mx5/mm.c                            |    8 +-
 arch/arm/mach-mx5/mx51_efika.c                    |   17 +-
 arch/arm/mach-mxs/include/mach/gpio.h             |    4 -
 arch/arm/mach-mxs/include/mach/mxs.h              |    2 +
 arch/arm/mach-mxs/mach-mx23evk.c                  |    1 -
 arch/arm/mach-mxs/mach-mx28evk.c                  |    1 -
 arch/arm/mach-mxs/mach-stmp378x_devb.c            |    1 -
 arch/arm/plat-mxc/audmux-v2.c                     |   18 +-
 arch/arm/plat-mxc/devices.c                       |   14 -
 arch/arm/plat-mxc/devices/Kconfig                 |    2 +-
 arch/arm/plat-mxc/devices/platform-fsl-usb2-udc.c |    5 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c      |    6 +
 arch/arm/plat-mxc/devices/platform-mxc-ehci.c     |    9 +
 arch/arm/plat-mxc/include/mach/common.h           |    1 -
 arch/arm/plat-mxc/include/mach/gpio.h             |    9 +-
 arch/arm/plat-mxc/include/mach/hardware.h         |    6 +
 arch/arm/plat-mxc/include/mach/iomux-mx51.h       | 2270 +++++---------
 arch/arm/plat-mxc/include/mach/iomux-mx53.h       | 3530 +++++++--------------
 arch/arm/plat-mxc/include/mach/iomux-v3.h         |    1 +
 arch/arm/plat-mxc/include/mach/mx51.h             |  167 +-
 drivers/gpio/gpio-mxc.c                           |   12 +
 drivers/gpio/gpio-mxs.c                           |    2 +
 44 files changed, 2173 insertions(+), 4216 deletions(-)
 delete mode 100644 arch/arm/mach-mx5/devices.c
 delete mode 100644 arch/arm/mach-mx5/devices.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
