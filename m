From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 10 Mar 2011 14:44:13 +0100
Subject: i.MX Pull request for -next
Message-ID: <20110310134412.GD29521@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

please pull the following for the next merge window.

The merge conflict against your devel branch can be resolved as follows:

diff --cc arch/arm/mach-mxs/gpio.c
index 61991e4,5120ab5..56fa2ed
--- a/arch/arm/mach-mxs/gpio.c
+++ b/arch/arm/mach-mxs/gpio.c
@@@ -182,11 -182,12 +182,12 @@@ static int mxs_gpio_set_wake_irq(struc
  }
  
  static struct irq_chip gpio_irq_chip = {
+ 	.name = "mxs gpio",
 -	.ack = mxs_gpio_ack_irq,
 -	.mask = mxs_gpio_mask_irq,
 -	.unmask = mxs_gpio_unmask_irq,
 -	.set_type = mxs_gpio_set_irq_type,
 -	.set_wake = mxs_gpio_set_wake_irq,
 +	.irq_ack = mxs_gpio_ack_irq,
 +	.irq_mask = mxs_gpio_mask_irq,
 +	.irq_unmask = mxs_gpio_unmask_irq,
 +	.irq_set_type = mxs_gpio_set_irq_type,
 +	.irq_set_wake = mxs_gpio_set_wake_irq,
  };
  

The following changes since commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:

  Linux 2.6.38-rc4 (2011-02-07 16:03:55 -0800)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Alberto Panizzo (4):
      spi_imx: Fix misspelled configuration variable SOC_IMX31
      mach-mx31_3ds: Add support for the MMC slot of the personality board
      mach-mx31_3ds: Add support for framebuffer and LCD
      mach-mx31_3ds: Add support for the camera device on the personality board

Alexander Stein (1):
      plat-mxc: Provide irq_chip name for GPIO IRQs

Arnaud Patard (5):
      Introduce EFIKA_COMMON
      efikamx: add usb h1 support
      efikamx: add mc13892 support / implement power off
      efika: enable cpufreq
      mx51: add support for efika smartbook

Baruch Siach (2):
      ARM: imx/mx25: fix (again) spi device registration typo
      ARM: imx/mx25: dynamically allocate pwm devices

Daiane Angolini (1):
      ARM: mx5/mx51_3ds: Add watchdog support

David Jander (1):
      ARM: imx+mx3: convert to mc13xxx MFD

Denis 'GNUtoo' Carikli (1):
      mx31: add support for the bugbase 1.3 from buglabs

Dinh Nguyen (1):
      ARM: i.MX53: Add full iomux support for mx53

Eric B?nard (5):
      eukrea-tlv320: add MBIMXSD51 support
      cpuimx51sd: add cpufreq support
      cpuimx51sd: fix tsc2007
      cpuimx51sd: mcp2515 supports up to 10MHz SPI clock
      i.MX25: add sdma clock definitions

Fabio Estevam (19):
      ARM: mx5: Use dummy clock for the keypad
      ARM: imx: Add initial support for IMX27IPCAM board
      ARM: mach-mx3/mach-mx31_3ds: Remove unnecessary function for IO mapping
      ARM: mach-mx5: Fix build for mx53_loco and mx53_smd
      ARM: mach-mx5/board-mx53_loco: Make UART1 functional
      ARM: mach-mx5/board-mx53_loco: Remove unused UARTs
      ARM: mx5/board-mx53_smd.c: Make UART1 functional
      ARM: mx5/board-mx53_evk.c: Make UART1 functional
      ARM: mx5: Add watchdog support for MX53
      ARM: mach-mx5: Add watchdog support for MX53 based boards
      ARM: imx/mach-mx25_3ds: Use IMX_GPIO_NR instead of hard-coded values
      ARM: mx35_3ds: Add I2C support
      ARM: mx31_3ds: Add I2C support
      ARM: mx27_3ds: Add I2C support
      ARM: mx25_3ds: Add I2C support
      ARM: mx53_smd: Add I2C support
      ARM: mx3/mx35_3ds: Use MX35 USB OTG Erratum
      ARM: mx5/mx53_smd: Fix IOMUX for UART2
      ARM: mx5/mx53_evk: Fix IOMUX for UART3

Frank Li (1):
      ARM: imx53_smd add uncompress print

Gwenhael Goavec-Merou (5):
      MX1: Rename SPI interrupt name and base address.
      MX1: Register clock for SPI2
      MX1: Add data structure for SPI
      MX1: Add registration functions for SPI.
      MX1: Add structure, registration functions for framebuffer and rename LCDC INT

Ilia Mirkin (1):
      arm: imx: Zero entire imxdma structure

Jason Liu (1):
      ARM i.MX50: Rename devices-mx50.h

Javier Martin (1):
      ARM: Add SSI and aic3204 code to Visstrim_M10 boards.

Jesper Juhl (1):
      Freescale STMP37XX/STMP378X Application UART driver: remove duplicate linux/device.h include

Julien Boibessot (1):
      i.MX51 iomux: Fixes MX51_PAD_UART2_TXD__UART2_TXD & MX51_PAD_USBH1_DATA2__UART2_TXD declarations

Lothar Wa?mann (3):
      ARM: mxs: free dma_mask in error path
      ARM: mxs: add a dma mask to fec devices
      ARM: mxs: Initial support for Ka-Ro TX28

Marc Kleine-Budde (2):
      ARM: mxs: adjust flexcan clock definition
      ARM: mxs: dynamically register flexcan devices for mx28

Marc Reilly (1):
      Introduce VPR200 board.

Richard Zhao (9):
      arm: mx50_rdp: add fec support
      arm: mx50_rdp: add i2c bus support
      ARM: imx53_loco: add all pad configure.
      ARM: imx53_loco add uncompress print
      ARM: imx53_loco: add i2c device support
      ARM: imx50: correct iomux-mx50.h wrong daisy chain settings
      ARM: imx53: correct Silicon Revision definition following fuse map
      ARM: imx5x: clean up ARCH_MX5X
      ARM: imx3x: clean up ARCH_MX3X

Richard Zhu (4):
      ARM: imx53: add sdhc pad settings
      ARM: imx51/53: add sdhc3/4 clock
      ARM: imx53_loco: add esdhc device support
      mx51 enchance the sd/mmc HW timing compatibility on mx51 boards.

Ryan Lortie (2):
      ARM: imx35: fix ATA_DATA3 pad control address
      ARM: imx35: fix trivial copy/paste error

Sascha Hauer (31):
      serial: Add auart driver for i.MX23/28
      ARM MXS: Add auart platform support for i.MX28
      ARM i.MX35 pcm043: remove unnecessary CONFIG_I2C ifdefs
      ARM i.MX35 pcm043: put usbh1 outside CONFIG_USB_ULPI
      ARM i.MX31 mx31ads: remove unnecessary CONFIG_I2C ifdefs
      ARM i.MX31 mx31ads: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX31 mx31ads: remove unnecessary CONFIG_SERIAL_8250 ifdefs
      ARM i.MX27 pca100: remove unnecessary CONFIG_SPI_IMX ifdefs
      ARM i.MX27 eukrea mbimx27: remove unnecessary CONFIG_SPI_IMX ifdefs
      ARM i.MX31 pcm037 eet: remove unnecessary CONFIG_SPI_IMX ifdefs
      ARM i.MX51 mx51 3ds: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX51 mx51 babbage: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX51 mx51-3ds: remove unnecessary CONFIG_KEYBOARD_IMX ifdefs
      ARM i.MX51 cpuimx51: remove unnecessary CONFIG_SERIAL_8250 ifdefs
      ARM i.MX51 efikamx: remove unnecessary CONFIG_SERIAL_IMX ifdefs
      ARM i.MX23/28: deobfuscate gpio initialization
      ARM i.MX23/28: do not use complicated macros if not necessary
      ARM i.MX23: remove reserved register defines
      ARM i.MX28: remove reserved register defines
      Merge branch 'imx-board-ifdefs' into imx-for-2.6.39
      Merge commit 'v2.6.38-rc4' into imx-for-2.6.39
      ARM i.MX ehci: factor out soc specific functions
      ARM i.MX ehci: do ehci init in board specific functions
      ARM: mxs: Add pwm clocks and device registration
      ARM: mxs: Add missing EXPORT_SYMBOL for mxs_reset_block
      video: Add i.MX23/28 framebuffer driver
      ARM i.MX23/28: Add framebuffer device support
      ARM i.MX: Move gpio initialization to SoC specific files
      ARM i.MX: iomux v1 initialization away from initcall
      ARM i.MX31 lilly: remove incomplete otg support
      ARM i.MX: introduce imx_otg_ulpi_create to create ULPI transceivers

Shawn Guo (17):
      ARM: mxs: add ocotp read function
      ARM: mxs/mx28evk: read fec mac address from ocotp
      ARM: mxs: add initial pm support
      ARM: mx23: rename mx23 auart irq definition to align with mx28
      ARM: mx23: dynamically allocate mx23 auart device
      ARM: mxs/mx23evk: add auart device
      ARM: mxs/mx28evk: add auart devices
      ARM: mx51_defconfig: change CONFIG_LEDS_CLASS 'm' to 'y'
      ARM: mxs: add helper macro for pad control
      ARM: mxs: fix typo "GPO" in iomux-mx23.h
      ARM: mxs/mx23evk: add framebuffer device
      ARM: mxs: add dma channel definitions
      ARM: mxs: add dma device
      ARM: mxs: make ssp error irq definition consistent
      ARM: mxs/mx28evk: add flexcan devices
      ARM: mx28: set proper parent for lcdif clock
      ARM: mxs/mx28evk: add framebuffer device

Uwe Kleine-K?nig (15):
      ARM: imx/eukrea_mbimx27: fix compile warnings about unused variables
      ARM: mx3/mx31_3ds: fix compiler warning without CONFIG_USB_ULPI
      ARM: imx: use .init_early to initialize cpu type and reset address
      ARM: mx3: use .init_early to initialize cpu type, reset address and iomuxer
      ARM: mx5: use .init_early to initialize cpu type, reset address and iomuxer
      ARM: mxc91231: use .init_early to initialize cpu type
      ARM: mx3+mx5: rename mxc_board_init to ${machine}_init
      ARM: mx3: remove some useless comments
      ARM: mx3/mx31ads: fix comments of irq callbacks
      ARM: mxc: free dma_mask in error path
      ARM: mxc: add a dma mask to fec devices
      ARM: mx3/cpuimx35: fix build failure
      ARM: iomux-imx31: allow pin_list to be const
      ARM: mxc91231/iomux: allow pin_list to be const
      ARM: mxc91231: select MXC_AVIC

Wolfram Sang (4):
      arm: mach-mx3: use IMX_GPIO_NR instead of hard-coded values
      arm: mxs: add i2c-devices for mx28
      arm: mxs: tx28: add i2c bus and connected RTC
      arm: mxs: add irq_chip-name for GPIO IRQs

 arch/arm/configs/mx51_defconfig                    |    2 +-
 arch/arm/mach-imx/Kconfig                          |   12 +
 arch/arm/mach-imx/Makefile                         |    5 +-
 arch/arm/mach-imx/clock-imx1.c                     |    1 +
 arch/arm/mach-imx/clock-imx25.c                    |    3 +
 arch/arm/mach-imx/devices-imx1.h                   |   11 +
 arch/arm/mach-imx/devices-imx25.h                  |    6 +-
 arch/arm/mach-imx/dma-v1.c                         |    2 +-
 arch/arm/mach-imx/ehci-imx25.c                     |   80 +
 arch/arm/mach-imx/ehci-imx27.c                     |   82 +
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c       |    7 +-
 arch/arm/mach-imx/mach-cpuimx27.c                  |   49 +-
 arch/arm/mach-imx/mach-eukrea_cpuimx25.c           |   27 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c        |   32 +-
 arch/arm/mach-imx/mach-imx27ipcam.c                |   78 +
 arch/arm/mach-imx/mach-imx27lite.c                 |   11 +-
 arch/arm/mach-imx/mach-mx1ads.c                    |   22 +-
 arch/arm/mach-imx/mach-mx21ads.c                   |   11 +-
 arch/arm/mach-imx/mach-mx25_3ds.c                  |   32 +-
 arch/arm/mach-imx/mach-mx27_3ds.c                  |   43 +-
 arch/arm/mach-imx/mach-mx27ads.c                   |   11 +-
 arch/arm/mach-imx/mach-mxt_td60.c                  |   12 +-
 arch/arm/mach-imx/mach-pca100.c                    |   49 +-
 arch/arm/mach-imx/mach-pcm038.c                    |   27 +-
 arch/arm/mach-imx/mach-scb9328.c                   |   13 +-
 arch/arm/mach-imx/mm-imx1.c                        |   21 +-
 arch/arm/mach-imx/mm-imx21.c                       |   23 +-
 arch/arm/mach-imx/mm-imx25.c                       |   18 +-
 arch/arm/mach-imx/mm-imx27.c                       |   23 +-
 arch/arm/mach-mx3/Kconfig                          |   25 +
 arch/arm/mach-mx3/Makefile                         |    6 +-
 arch/arm/mach-mx3/devices-imx35.h                  |    2 +-
 arch/arm/mach-mx3/ehci-imx31.c                     |   83 +
 arch/arm/mach-mx3/ehci-imx35.c                     |   80 +
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c       |    4 +-
 arch/arm/mach-mx3/iomux-imx31.c                    |   12 +-
 arch/arm/mach-mx3/mach-armadillo5x0.c              |   41 +-
 arch/arm/mach-mx3/mach-bug.c                       |   66 +
 arch/arm/mach-mx3/mach-cpuimx35.c                  |   31 +-
 arch/arm/mach-mx3/mach-kzm_arm11_01.c              |   17 +-
 arch/arm/mach-mx3/mach-mx31_3ds.c                  |  462 ++++-
 arch/arm/mach-mx3/mach-mx31ads.c                   |   57 +-
 arch/arm/mach-mx3/mach-mx31lilly.c                 |   95 +-
 arch/arm/mach-mx3/mach-mx31lite.c                  |   37 +-
 arch/arm/mach-mx3/mach-mx31moboard.c               |   39 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c                  |   42 +-
 arch/arm/mach-mx3/mach-pcm037.c                    |   46 +-
 arch/arm/mach-mx3/mach-pcm037_eet.c                |    2 -
 arch/arm/mach-mx3/mach-pcm043.c                    |   54 +-
 arch/arm/mach-mx3/mach-qong.c                      |   22 +-
 arch/arm/mach-mx3/mach-vpr200.c                    |  328 +++
 arch/arm/mach-mx3/mm.c                             |   43 +-
 arch/arm/mach-mx3/mx31moboard-devboard.c           |    7 +-
 arch/arm/mach-mx3/mx31moboard-marxbot.c            |    6 +-
 arch/arm/mach-mx3/mx31moboard-smartbot.c           |   13 +-
 arch/arm/mach-mx5/Kconfig                          |   27 +-
 arch/arm/mach-mx5/Makefile                         |    4 +-
 arch/arm/mach-mx5/board-cpuimx51.c                 |   20 +-
 arch/arm/mach-mx5/board-cpuimx51sd.c               |   31 +-
 arch/arm/mach-mx5/board-mx50_rdp.c                 |   34 +-
 arch/arm/mach-mx5/board-mx51_3ds.c                 |   43 +-
 arch/arm/mach-mx5/board-mx51_babbage.c             |   43 +-
 arch/arm/mach-mx5/board-mx51_efikamx.c             |  211 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c             |  283 +++
 arch/arm/mach-mx5/board-mx53_evk.c                 |   40 +-
 arch/arm/mach-mx5/board-mx53_loco.c                |  178 ++-
 arch/arm/mach-mx5/board-mx53_smd.c                 |   40 +-
 arch/arm/mach-mx5/clock-mx51-mx53.c                |  148 ++-
 arch/arm/mach-mx5/cpu.c                            |   11 +-
 arch/arm/mach-mx5/crm_regs.h                       |    7 +
 .../mach-mx5/{devices-mx50.h => devices-imx50.h}   |    8 +
 arch/arm/mach-mx5/devices-imx53.h                  |    4 +
 arch/arm/mach-mx5/efika.h                          |   10 +
 arch/arm/mach-mx5/ehci.c                           |  156 ++
 arch/arm/mach-mx5/mm-mx50.c                        |   19 +-
 arch/arm/mach-mx5/mm.c                             |   14 +-
 arch/arm/mach-mx5/mx51_efika.c                     |  636 +++++
 arch/arm/mach-mxc91231/iomux.c                     |   14 +-
 arch/arm/mach-mxc91231/magx-zn5.c                  |   11 +-
 arch/arm/mach-mxc91231/mm.c                        |    7 +-
 arch/arm/mach-mxs/Kconfig                          |   24 +
 arch/arm/mach-mxs/Makefile                         |    5 +
 arch/arm/mach-mxs/clock-mx23.c                     |   11 +-
 arch/arm/mach-mxs/clock-mx28.c                     |   25 +-
 arch/arm/mach-mxs/devices-mx23.h                   |   11 +
 arch/arm/mach-mxs/devices-mx28.h                   |   23 +
 arch/arm/mach-mxs/devices.c                        |    2 +
 arch/arm/mach-mxs/devices/Kconfig                  |   16 +
 arch/arm/mach-mxs/devices/Makefile                 |    6 +
 arch/arm/mach-mxs/devices/platform-auart.c         |   64 +
 arch/arm/mach-mxs/devices/platform-dma.c           |   49 +
 arch/arm/mach-mxs/devices/platform-fec.c           |    5 +-
 arch/arm/mach-mxs/devices/platform-flexcan.c       |   51 +
 arch/arm/mach-mxs/devices/platform-mxs-i2c.c       |   51 +
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c       |   22 +
 arch/arm/mach-mxs/devices/platform-mxsfb.c         |   46 +
 arch/arm/mach-mxs/gpio.c                           |   46 +-
 arch/arm/mach-mxs/include/mach/common.h            |    1 +
 arch/arm/mach-mxs/include/mach/devices-common.h    |   35 +
 arch/arm/mach-mxs/include/mach/iomux-mx23.h        |  190 +-
 arch/arm/mach-mxs/include/mach/iomux.h             |    3 +
 arch/arm/mach-mxs/include/mach/mx23.h              |   38 +-
 arch/arm/mach-mxs/include/mach/mx28.h              |   45 +-
 arch/arm/mach-mxs/include/mach/mxs.h               |    9 +-
 arch/arm/mach-mxs/include/mach/mxsfb.h             |   49 +
 arch/arm/mach-mxs/include/mach/uncompress.h        |    1 +
 arch/arm/mach-mxs/mach-mx23evk.c                   |   90 +-
 arch/arm/mach-mxs/mach-mx28evk.c                   |  237 ++-
 arch/arm/mach-mxs/mach-tx28.c                      |  183 ++
 arch/arm/mach-mxs/module-tx28.c                    |  131 +
 arch/arm/mach-mxs/module-tx28.h                    |    9 +
 arch/arm/mach-mxs/ocotp.c                          |   90 +
 arch/arm/mach-mxs/pm.c                             |   43 +
 arch/arm/mach-mxs/regs-clkctrl-mx23.h              |  124 -
 arch/arm/mach-mxs/regs-clkctrl-mx28.h              |  177 --
 arch/arm/mach-mxs/system.c                         |    2 +
 arch/arm/mm/Kconfig                                |    2 +-
 arch/arm/plat-mxc/Kconfig                          |    1 +
 arch/arm/plat-mxc/Makefile                         |    1 -
 arch/arm/plat-mxc/devices.c                        |    2 +
 arch/arm/plat-mxc/devices/platform-fec.c           |    9 +-
 arch/arm/plat-mxc/devices/platform-imx-dma.c       |    6 +-
 arch/arm/plat-mxc/devices/platform-imx-fb.c        |    5 +
 arch/arm/plat-mxc/devices/platform-imx-i2c.c       |   10 +
 arch/arm/plat-mxc/devices/platform-imx2-wdt.c      |    9 +
 arch/arm/plat-mxc/devices/platform-spi_imx.c       |    9 +
 arch/arm/plat-mxc/ehci.c                           |  369 ---
 arch/arm/plat-mxc/gpio.c                           |  111 +-
 arch/arm/plat-mxc/include/mach/common.h            |   10 +
 arch/arm/plat-mxc/include/mach/gpio.h              |   15 +
 arch/arm/plat-mxc/include/mach/iomux-mx3.h         |    8 +-
 arch/arm/plat-mxc/include/mach/iomux-mx35.h        |   14 +-
 arch/arm/plat-mxc/include/mach/iomux-mx50.h        |   44 +-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h        |   44 +-
 arch/arm/plat-mxc/include/mach/iomux-mx53.h        | 2639 +++++++++++++++++---
 arch/arm/plat-mxc/include/mach/iomux-mxc91231.h    |    8 +-
 arch/arm/plat-mxc/include/mach/iomux-v1.h          |    2 +
 arch/arm/plat-mxc/include/mach/irqs.h              |    6 +-
 arch/arm/plat-mxc/include/mach/mx1.h               |    9 +-
 arch/arm/plat-mxc/include/mach/mx53.h              |    2 +-
 arch/arm/plat-mxc/include/mach/mxc.h               |   10 +-
 arch/arm/plat-mxc/include/mach/mxc_ehci.h          |    7 +-
 arch/arm/plat-mxc/include/mach/ulpi.h              |    9 +
 arch/arm/plat-mxc/include/mach/uncompress.h        |    7 +
 arch/arm/plat-mxc/iomux-v1.c                       |   24 +-
 arch/arm/plat-mxc/ulpi.c                           |    5 +
 drivers/mtd/nand/Kconfig                           |    2 +-
 drivers/net/Kconfig                                |    2 +-
 drivers/spi/Kconfig                                |    6 +-
 drivers/tty/serial/Kconfig                         |   15 +
 drivers/tty/serial/Makefile                        |    1 +
 drivers/tty/serial/mxs-auart.c                     |  798 ++++++
 drivers/usb/gadget/fsl_mxc_udc.c                   |    2 +-
 drivers/usb/host/ehci-mxc.c                        |    5 -
 drivers/video/Kconfig                              |    9 +
 drivers/video/Makefile                             |    1 +
 drivers/video/mxsfb.c                              |  919 +++++++
 sound/soc/imx/Kconfig                              |    3 +-
 sound/soc/imx/eukrea-tlv320.c                      |    3 +-
 159 files changed, 9222 insertions(+), 2187 deletions(-)
 create mode 100644 arch/arm/mach-imx/ehci-imx25.c
 create mode 100644 arch/arm/mach-imx/ehci-imx27.c
 create mode 100644 arch/arm/mach-imx/mach-imx27ipcam.c
 create mode 100644 arch/arm/mach-mx3/ehci-imx31.c
 create mode 100644 arch/arm/mach-mx3/ehci-imx35.c
 create mode 100644 arch/arm/mach-mx3/mach-bug.c
 create mode 100644 arch/arm/mach-mx3/mach-vpr200.c
 create mode 100644 arch/arm/mach-mx5/board-mx51_efikasb.c
 rename arch/arm/mach-mx5/{devices-mx50.h => devices-imx50.h} (78%)
 create mode 100644 arch/arm/mach-mx5/efika.h
 create mode 100644 arch/arm/mach-mx5/ehci.c
 create mode 100644 arch/arm/mach-mx5/mx51_efika.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-auart.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-dma.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-flexcan.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-i2c.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-pwm.c
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c
 create mode 100644 arch/arm/mach-mxs/include/mach/mxsfb.h
 create mode 100644 arch/arm/mach-mxs/mach-tx28.c
 create mode 100644 arch/arm/mach-mxs/module-tx28.c
 create mode 100644 arch/arm/mach-mxs/module-tx28.h
 create mode 100644 arch/arm/mach-mxs/ocotp.c
 create mode 100644 arch/arm/mach-mxs/pm.c
 delete mode 100644 arch/arm/plat-mxc/ehci.c
 create mode 100644 drivers/tty/serial/mxs-auart.c
 create mode 100644 drivers/video/mxsfb.c
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
