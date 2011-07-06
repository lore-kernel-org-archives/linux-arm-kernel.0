From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 6 Jul 2011 10:24:18 +0200
Subject: [GIT PULL] i.MX patches for next merge window
Message-ID: <20110706082418.GQ6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the following i.MX related changes for the next merge
window.

Sascha

The following changes since commit a2fa83faf47b514ab947cea916d3691b66525073:

  Merge branch 'usb-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb-2.6 (2011-07-05 20:57:45 -0700)

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

Axel Lin (1):
      ARM i.MX23/28: platform-mxsfb: Add missing include of linux/dma-mapping.h

Daiane Angolini (1):
      ARM: mach-mx5/mx53_ard: Add gpio_keys support

Dinh Nguyen (1):
      ARM: mx51: Add support for low power suspend on MX51

Fabio Estevam (27):
      ARM: mx5/mx51_babbage: Move GPIO initialization for USB PHY Reset line to common place
      ARM: mx5/mx51_babbage: Use gpio_request_array for USBH1 pins
      mx51: Let USB Storage be built by default
      ARM: mx5/mx53_loco: Add support for LED
      ARM: mx5/mx53_evk: Add support for LED
      ARM: imx/mach-apf9328: Simplify UART0 registration
      ARM: mx53: Fix alternate modes for MX53_PAD_PATA_DATA6
      ARM: mx53: Fix the chip select addresses
      ARM: mx53: Add SDMA clock
      ARM: mx53: Add SDMA support for MX53
      ARM: mach-imx/mx31_3ds: Fix IOMUX for SPI1 signals
      ARM: imx2: Fix GPIO iosize
      ARM: mach-imx/scb9328: Make the UART gpio setup simpler
      mxc: iomuxv1: Do not use gpio_request when setting the pin as GPIO
      ARM: mach-imx/mx27_3ds: Use the standard i.MX macro for GPIO numbering
      ARM: mach-imx/mx27_3ds: Fix regulator support
      ARM: mach-imx/mx27_3ds: Add LCD support
      ARM: mach-imx/mx27_3ds: Add touchscreen support
      ARM: mach-imx/mx27_3ds: Use the standard gpio_to_irq function
      ARM: mach-imx/mx27_3ds: Do not annotate the chip select as internal
      ARM: mxc: iomux-v1: Fix build warning
      ARM: mx53: Add support for missing UARTs
      ARM: mx53: Add SSI suport
      ARM: mx51: Fix the address space length for SSI
      ARM: mx53: Add keypad support
      ARM: mx53: Fix some interrupts marked as reserved.
      ARM: mach-mx5/mx53_ard: Add missing definition

Grant Likely (1):
      gpio/mxs: Move Freescale mxs gpio driver to drivers/gpio

H Hartley Sweeten (1):
      plat-mxc/pwm.c: use resource_size()

J?rgen Lambrecht (1):
      Enable RTC driver.

Lothar Wa?mann (1):
      mach-mx5: fix the I2C clock parents

Marc Kleine-Budde (1):
      ARM: mx53: Fix the base addresses for the DDR memory regions

Sascha Hauer (10):
      Merge remote-tracking branch 'grant/gpio/next-mx' into devel
      ARM i.MX: fix last user of iomux.h and remove it
      ARM i.MX: define CLOCK_TICK_RATE to bogus value
      ARM i.MX: remove SoC defines around header includes
      ARM i.MX: dmav1: kill SoC ifdefs
      ARM i.MX mxc.h: use CONFIG_SOC_* instead of CONFIG_ARCH_*
      ARM i.MX tzic: do not depend on MXC_INTERNAL_IRQS
      ARM i.MX avic: do not depend on MXC_INTERNAL_IRQS
      ARM i.MX: get rid of wrong MXC_INTERNAL_IRQ usage
      ARM i.MX debug macro: use CONFIG_SOC_* instead of CONFIG_ARCH_*

Shawn Guo (14):
      gpio/mxs: Change gpio-mxs into an upstanding gpio driver
      gpio/mxc: Move Freescale MXC gpio driver to drivers/gpio
      gpio/mxc: Change gpio-mxc into an upstanding gpio driver
      gpio/mxc: convert gpio-mxc to use basic_mmio_gpio library
      ARM: mxs_defconfig: Change CONFIG_RTC_CLASS 'm' to 'y'
      ARM: mxs_defconfig: Add mx23evk and mx28evk build
      ARM: mxs/mx28evk: add leds-gpio device for heartbeat
      ARM: mxc: convert tzic to use generic irq chip
      ARM: mxc: imx-sdma device gets 16K iosize than 4K
      ARM: mxc: sdma on imx25 is a V2 block
      ARM: mxc: change imx-dma default to_version to 1
      ARM: mxc: imx-dma on imx25 has no other TO version but TO1
      ARM: mxc: clean up imx-dma device registration
      dmaengine: imx-sdma: pass sdma firmware name via platform data

Troy Kisky (1):
      MXC: iomux-v3: correct NO_PAD_CTRL definition

Uwe Kleine-K?nig (4):
      ARM: imx: convert to new leds-gpio registration helper
      ARM: mx5: convert to new leds-gpio registration helper
      ARM: mxs/tx28: convert to new leds-gpio registration helper
      ARM: mxs/tx28: according to the TX28's datasheet D4-D7 are not used for MMC0

Wolfram Sang (1):
      arm: mxs: add mmc-device for mach-tx28

 arch/arm/Kconfig                                   |    1 +
 arch/arm/configs/mx51_defconfig                    |    3 +-
 arch/arm/configs/mxs_defconfig                     |    4 +-
 arch/arm/mach-imx/Kconfig                          |    6 +
 arch/arm/mach-imx/dma-v1.c                         |   25 +--
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |   23 +--
 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |   15 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |   13 +-
 arch/arm/mach-imx/mach-apf9328.c                   |    9 +-
 arch/arm/mach-imx/mach-armadillo5x0.c              |    2 +
 arch/arm/mach-imx/mach-bug.c                       |    2 +
 arch/arm/mach-imx/mach-cpuimx27.c                  |    2 +
 arch/arm/mach-imx/mach-cpuimx35.c                  |    2 +
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |    2 +
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |    4 +-
 arch/arm/mach-imx/mach-imx27ipcam.c                |    2 +
 arch/arm/mach-imx/mach-imx27lite.c                 |    2 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c              |    2 +
 arch/arm/mach-imx/mach-mx1ads.c                    |    2 +
 arch/arm/mach-imx/mach-mx21ads.c                   |    2 +
 arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
 arch/arm/mach-imx/mach-mx27_3ds.c                  |  139 +++++++++-
 arch/arm/mach-imx/mach-mx27ads.c                   |    2 +
 arch/arm/mach-imx/mach-mx31_3ds.c                  |   12 +-
 arch/arm/mach-imx/mach-mx31ads.c                   |    2 +
 arch/arm/mach-imx/mach-mx31lilly.c                 |    2 +
 arch/arm/mach-imx/mach-mx31lite.c                  |    2 +
 arch/arm/mach-imx/mach-mx31moboard.c               |   16 +-
 arch/arm/mach-imx/mach-mx35_3ds.c                  |    4 +-
 arch/arm/mach-imx/mach-mxt_td60.c                  |    2 +
 arch/arm/mach-imx/mach-pca100.c                    |    2 +
 arch/arm/mach-imx/mach-pcm037.c                    |    2 +
 arch/arm/mach-imx/mach-pcm038.c                    |    2 +
 arch/arm/mach-imx/mach-pcm043.c                    |    2 +
 arch/arm/mach-imx/mach-qong.c                      |    2 +
 arch/arm/mach-imx/mach-scb9328.c                   |   19 +-
 arch/arm/mach-imx/mach-vpr200.c                    |    2 +
 arch/arm/mach-imx/mm-imx1.c                        |   21 +-
 arch/arm/mach-imx/mm-imx21.c                       |   24 +-
 arch/arm/mach-imx/mm-imx25.c                       |   41 +++-
 arch/arm/mach-imx/mm-imx27.c                       |   24 +-
 arch/arm/mach-imx/mm-imx31.c                       |   42 +++-
 arch/arm/mach-imx/mm-imx35.c                       |   62 ++++-
 arch/arm/mach-imx/mx31lite-db.c                    |   15 +-
 arch/arm/mach-mx5/Kconfig                          |   18 ++
 arch/arm/mach-mx5/Makefile                         |    2 +
 arch/arm/mach-mx5/board-cpuimx51.c                 |   14 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c               |    2 +
 arch/arm/mach-mx5/board-mx50_rdp.c                 |    2 +
 arch/arm/mach-mx5/board-mx51_3ds.c                 |    5 +-
 arch/arm/mach-mx5/board-mx51_babbage.c             |   58 +++--
 arch/arm/mach-mx5/board-mx51_efikamx.c             |   17 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c             |   18 +-
 arch/arm/mach-mx5/board-mx53_ard.c                 |  254 +++++++++++++++++++
 arch/arm/mach-mx5/board-mx53_evk.c                 |   19 ++
 arch/arm/mach-mx5/board-mx53_loco.c                |   37 +++-
 arch/arm/mach-mx5/board-mx53_smd.c                 |    2 +
 arch/arm/mach-mx5/clock-mx51-mx53.c                |   22 ++-
 arch/arm/mach-mx5/crm_regs.h                       |    2 +
 arch/arm/mach-mx5/devices-imx53.h                  |    8 +
 arch/arm/mach-mx5/devices.c                        |   64 -----
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c       |   24 +--
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c       |   19 +--
 arch/arm/mach-mx5/mm-mx50.c                        |   21 +-
 arch/arm/mach-mx5/mm.c                             |   69 +++++-
 arch/arm/mach-mx5/pm-imx5.c                        |   73 ++++++
 arch/arm/mach-mxs/Kconfig                          |    3 +
 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/devices.c                        |   11 +
 arch/arm/mach-mxs/devices/Makefile                 |    1 +
 arch/arm/mach-mxs/devices/platform-gpio-mxs.c      |   53 ++++
 arch/arm/mach-mxs/devices/platform-mxsfb.c         |    1 +
 arch/arm/mach-mxs/gpio.h                           |   34 ---
 arch/arm/mach-mxs/include/mach/devices-common.h    |    2 +
 arch/arm/mach-mxs/mach-mx28evk.c                   |   22 ++-
 arch/arm/mach-mxs/mach-tx28.c                      |   19 +-
 arch/arm/mach-mxs/mm-mx23.c                        |    1 -
 arch/arm/mach-mxs/mm-mx28.c                        |    1 -
 arch/arm/plat-mxc/Makefile                         |    2 +-
 arch/arm/plat-mxc/avic.c                           |   12 +-
 arch/arm/plat-mxc/devices.c                        |   25 ++
 arch/arm/plat-mxc/devices/Makefile                 |    1 +
 arch/arm/plat-mxc/devices/platform-gpio-mxc.c      |   32 +++
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |  204 +--------------
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |    3 +-
 arch/arm/plat-mxc/devices/platform-imx-keypad.c    |    5 +
 arch/arm/plat-mxc/devices/platform-imx-ssi.c       |   12 +-
 arch/arm/plat-mxc/devices/platform-imx-uart.c      |    2 +
 arch/arm/plat-mxc/include/mach/common.h            |   12 +-
 arch/arm/plat-mxc/include/mach/debug-macro.S       |   10 +-
 arch/arm/plat-mxc/include/mach/devices-common.h    |    8 +
 arch/arm/plat-mxc/include/mach/gpio.h              |   27 --
 arch/arm/plat-mxc/include/mach/hardware.h          |   28 +--
 arch/arm/plat-mxc/include/mach/iomux-mx53.h        |   10 +-
 arch/arm/plat-mxc/include/mach/iomux-v1.h          |    4 -
 arch/arm/plat-mxc/include/mach/iomux-v3.h          |    2 +-
 arch/arm/plat-mxc/include/mach/iomux.h             |   26 --
 arch/arm/plat-mxc/include/mach/mx53.h              |   54 ++--
 arch/arm/plat-mxc/include/mach/mxc.h               |    8 +-
 arch/arm/plat-mxc/include/mach/sdma.h              |    6 +-
 arch/arm/plat-mxc/include/mach/timex.h             |   13 +-
 arch/arm/plat-mxc/include/mach/uncompress.h        |    1 +
 arch/arm/plat-mxc/iomux-v1.c                       |   34 +---
 arch/arm/plat-mxc/irq-common.c                     |   13 +-
 arch/arm/plat-mxc/pwm.c                            |    8 +-
 arch/arm/plat-mxc/tzic.c                           |   99 ++------
 drivers/dma/imx-sdma.c                             |    6 +-
 drivers/gpio/Kconfig                               |    9 +
 drivers/gpio/Makefile                              |    2 +
 .../arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c |  266 +++++++++++---------
 .../arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c |  227 ++++++++++-------
 111 files changed, 1564 insertions(+), 1073 deletions(-)
 create mode 100644 arch/arm/mach-mx5/board-mx53_ard.c
 create mode 100644 arch/arm/mach-mx5/pm-imx5.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpio-mxs.c
 delete mode 100644 arch/arm/mach-mxs/gpio.h
 create mode 100644 arch/arm/plat-mxc/devices/platform-gpio-mxc.c
 delete mode 100644 arch/arm/plat-mxc/include/mach/iomux.h
 rename arch/arm/plat-mxc/gpio.c => drivers/gpio/gpio-mxc.c (60%)
 rename arch/arm/mach-mxs/gpio.c => drivers/gpio/gpio-mxs.c (58%)
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
