From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 7 Jul 2011 10:17:11 +0200
Subject: [GIT PULL] i.MX feature additions
Message-ID: <20110707081711.GZ6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Please pull the following i.MX feature additions. This one is based on
the previous cleanup branch due to merge conflicts we would get
otherwise. I carefully looked that the end result is the same as the
previous devel pull request you denied.

Sascha


The following changes since commit fad107086d5a869c1c07e5bb35b7b57a10ecf578:

  ARM i.MX debug macro: use CONFIG_SOC_* instead of CONFIG_ARCH_* (2011-07-07 10:00:02 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git devel

Andre Silva (7):
      ARM: mach-mx5/mx53_ard: Add support for i.MX53 ARD board
      ARM:mach-mx5/board-mx53_loco: Add CD and WP GPIOs
      ARM:mach-mx5/board-mx51_babbage: Add CD and WP GPIOs
      ARM:mach-mx5/mx53_ard: Add ESDHC support
      ARM:mach-mx5/mx53_ard: Add Watchdog timer support
      ARM:mx53: Add I2C3 support
      ARM:mach-mx5/mx53_ard: Add I2C2 and I2C3 support

Daiane Angolini (1):
      ARM: mach-mx5/mx53_ard: Add gpio_keys support

Dinh Nguyen (1):
      ARM: mx51: Add support for low power suspend on MX51

Fabio Estevam (11):
      ARM: mx5/mx53_loco: Add support for LED
      ARM: mx5/mx53_evk: Add support for LED
      ARM: mx53: Add SDMA clock
      ARM: mx53: Add SDMA support for MX53
      ARM: imx2: Fix GPIO iosize
      ARM: mach-imx/mx27_3ds: Add LCD support
      ARM: mach-imx/mx27_3ds: Add touchscreen support
      ARM: mx53: Add support for missing UARTs
      ARM: mx53: Add SSI suport
      ARM: mx53: Add keypad support
      ARM: mach-mx5/mx53_ard: Add missing definition

Grant Likely (1):
      gpio/mxs: Move Freescale mxs gpio driver to drivers/gpio

J?rgen Lambrecht (1):
      Enable RTC driver.

Sascha Hauer (1):
      Merge remote-tracking branch 'grant/gpio/next-mx' into devel-features

Shawn Guo (9):
      gpio/mxs: Change gpio-mxs into an upstanding gpio driver
      gpio/mxc: Move Freescale MXC gpio driver to drivers/gpio
      gpio/mxc: Change gpio-mxc into an upstanding gpio driver
      gpio/mxc: convert gpio-mxc to use basic_mmio_gpio library
      ARM: mxs_defconfig: Add mx23evk and mx28evk build
      ARM: mxs/mx28evk: add leds-gpio device for heartbeat
      ARM: mxc: convert tzic to use generic irq chip
      ARM: mxc: clean up imx-dma device registration
      dmaengine: imx-sdma: pass sdma firmware name via platform data

Wolfram Sang (1):
      arm: mxs: add mmc-device for mach-tx28

 arch/arm/Kconfig                                   |    1 +
 arch/arm/configs/mxs_defconfig                     |    2 +
 arch/arm/mach-imx/Kconfig                          |    1 +
 arch/arm/mach-imx/mach-apf9328.c                   |    2 +
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +
 arch/arm/mach-imx/mach-bug.c                       |    2 +
 arch/arm/mach-imx/mach-cpuimx27.c                  |    2 +
 arch/arm/mach-imx/mach-cpuimx35.c                  |    2 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    2 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    2 +
 arch/arm/mach-imx/mach-imx27ipcam.c                |    2 +
 arch/arm/mach-imx/mach-imx27lite.c                 |    2 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c              |    2 +
 arch/arm/mach-imx/mach-mx1ads.c                    |    2 +
 arch/arm/mach-imx/mach-mx21ads.c                   |    2 +
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-mx27_3ds.c                  |   95 +++++++-
 arch/arm/mach-imx/mach-mx27ads.c                   |    2 +
 arch/arm/mach-imx/mach-mx31_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-mx31ads.c                   |    2 +
 arch/arm/mach-imx/mach-mx31lilly.c                 |    2 +
 arch/arm/mach-imx/mach-mx31lite.c                  |    2 +
 arch/arm/mach-imx/mach-mx31moboard.c               |    2 +
 arch/arm/mach-imx/mach-mx35_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-mxt_td60.c                  |    2 +
 arch/arm/mach-imx/mach-pca100.c                    |    2 +
 arch/arm/mach-imx/mach-pcm037.c                    |    2 +
 arch/arm/mach-imx/mach-pcm038.c                    |    2 +
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +
 arch/arm/mach-imx/mach-qong.c                      |    2 +
 arch/arm/mach-imx/mach-scb9328.c                   |    2 +
 arch/arm/mach-imx/mach-vpr200.c                    |    2 +
 arch/arm/mach-imx/mm-imx1.c                        |   21 +-
 arch/arm/mach-imx/mm-imx21.c                       |   24 +-
 arch/arm/mach-imx/mm-imx25.c                       |   41 +++-
 arch/arm/mach-imx/mm-imx27.c                       |   24 +-
 arch/arm/mach-imx/mm-imx31.c                       |   42 +++-
 arch/arm/mach-imx/mm-imx35.c                       |   62 ++++-
 arch/arm/mach-mx5/Kconfig                          |   14 +
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-cpuimx51.c                 |    2 +
 arch/arm/mach-mx5/board-cpuimx51sd.c               |    2 +
 arch/arm/mach-mx5/board-mx50_rdp.c                 |    2 +
 arch/arm/mach-mx5/board-mx51_3ds.c                 |    2 +
 arch/arm/mach-mx5/board-mx51_babbage.c             |   24 ++-
 arch/arm/mach-mx5/board-mx51_efikamx.c             |    2 +
 arch/arm/mach-mx5/board-mx51_efikasb.c             |    2 +
 arch/arm/mach-mx5/board-mx53_ard.c                 |  254 +++++++++++++++++++
 arch/arm/mach-mx5/board-mx53_evk.c                 |   19 ++
 arch/arm/mach-mx5/board-mx53_loco.c                |   37 +++-
 arch/arm/mach-mx5/board-mx53_smd.c                 |    2 +
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   18 ++
 arch/arm/mach-mx5/crm_regs.h                       |    2 +
 arch/arm/mach-mx5/devices-imx53.h                  |    8 +
 arch/arm/mach-mx5/devices.c                        |   64 -----
 arch/arm/mach-mx5/mm-mx50.c                        |   21 +-
 arch/arm/mach-mx5/mm.c                             |   69 +++++-
 arch/arm/mach-mx5/pm-imx5.c                        |   73 ++++++
 arch/arm/mach-mxs/Kconfig                          |    2 +
 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/devices.c                        |   11 +
 arch/arm/mach-mxs/devices/Makefile                 |    1 +
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   53 ++++
 arch/arm/mach-mxs/gpio.h                           |   34 ---
 arch/arm/mach-mxs/include/mach/devices-common.h    |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                   |   22 ++-
 arch/arm/mach-mxs/mach-tx28.c                      |    6 +
 arch/arm/mach-mxs/mm-mx23.c                        |    1 -
 arch/arm/mach-mxs/mm-mx28.c                        |    1 -
 arch/arm/plat-mxc/Makefile                         |    2 +-
 arch/arm/plat-mxc/devices.c                        |   25 ++
 arch/arm/plat-mxc/devices/Makefile                 |    1 +
 arch/arm/plat-mxc/devices/platform-gpio-mxc.c      |   32 +++
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |  204 +--------------
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |    3 +-
 arch/arm/plat-mxc/devices/platform-imx-keypad.c    |    5 +
 arch/arm/plat-mxc/devices/platform-imx-ssi.c       |   10 +
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    2 +
 arch/arm/plat-mxc/include/mach/common.h            |   12 +-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    8 +
 arch/arm/plat-mxc/include/mach/gpio.h              |   27 --
 arch/arm/plat-mxc/include/mach/mx53.h              |   28 +-
 arch/arm/plat-mxc/include/mach/sdma.h              |    6 +-
 arch/arm/plat-mxc/include/mach/uncompress.h        |    1 +
 arch/arm/plat-mxc/irq-common.c                     |   13 +-
 arch/arm/plat-mxc/tzic.c                           |   97 ++------
 drivers/dma/imx-sdma.c                             |    6 +-
 drivers/gpio/Kconfig                               |    9 +
 drivers/gpio/Makefile                              |    2 +
 .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c |  266 +++++++++++---------
 .../arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c |  227 ++++++++++-------
 91 files changed, 1389 insertions(+), 720 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx53_ard.c
 create mode 100644 arch/arm/mach-mx5/pm-imx5.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpio-mxs.c
 delete mode 100644 arch/arm/mach-mxs/gpio.h
 create mode 100644 arch/arm/plat-mxc/devices/platform-gpio-mxc.c
 rename arch/arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c (60%)
 rename arch/arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c (58%)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
