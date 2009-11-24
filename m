From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 24 Nov 2009 08:52:53 +0100
Subject: MXC Pull request for .33
Message-ID: <20091124075253.GI30179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Here are the mxc related patches for the next merge window.

Sascha

The following changes since commit b419148e567728f6af0c3b01965c1cc141e3e13a:
  Linus Torvalds (1):
        Linux 2.6.32-rc6

are available in the git repository at:

  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk

Alberto Panizzo (4):
      Armadillo500 Add support for onboard GPIO Buttons.
      Armadillo500 Correct bus length for SMSC9118 on board chip.
      Armadillo500 Add i2c second bus support.
      Armadillo500 Add support for Seiko Instruments S-35390A rtc over i2c.

Daniel Mack (14):
      ARM: MX3: remove I2C defintions from mx31lilly.c
      ARM: MX3: add SPI functions for lilly1131-db
      ARM: MX3: add support for mc13783 on lilly-db
      ARM: MX3: Add pad config for MMC pins on lilly-db
      ARM: MX3: add MX3X_UART1_BASE_ADDR for uncompression on lilly1131
      MXC: Add support for ULPI Viewports
      ARM: MX3: modularize 'mx31lite' code
      ARM: MX3: add MMC/SDHC support to mx31lite-db.c
      ARM: MX3: add SPI devices for mx31lite
      ARM: MX3: add USB functions for mx31litekit
      ARM: MX3: add support for GPIO LEDs on litekit db
      ARM: MX3: add NOR flash support via physmap mtd driver
      ARM: MX3: lilly1131: move MC13783 device registration
      ARM: MX3: fix CPU revision number detection

Juergen Beisert (2):
      MXC NFC: Add the clock resource to support NFC in i.MX35
      MXC NFC: Fix NFCs address area on i.MX35

Sascha Hauer (11):
      pca100: Add board to uncompress.h
      pca100: use correct irq initialisation function
      pcm043: Add NAND support
      i.MX2: Add sound (ssi) resources
      i.MX3: Add sound (ssi) resources
      MXC: Add a digital audio multiplexer driver
      i.MX35: Fix audmux clock
      mx3: Add SSI pins to iomux table
      mxc: iomux v3: remove resource handling
      i.MX31 clock: rename SSI clocks to driver name
      mxc: mx1/mx2 DMA: add a possibility to create an endless DMA transfer

Uwe Kleine-K?nig (16):
      imx/gpio: Use handle_level_irq
      imx: reorder mx2x.h
      imx: reorder mx21.h
      imx: reorder mx27.h
      imx: reorder mx3x.h
      imx: add namespace prefixes for symbols in mx2x.h
      imx: add namespace prefixes for symbols in mx21.h
      imx: add namespace prefixes for symbols in mx27.h
      imx: add namespace prefixes for symbols in mx3x.h
      imx: add namespace prefixes for symbols in mx31.h
      imx: add namespace prefixes for symbols in mx35.h
      imx: reformat mx25.h to match the other platform includes
      imx: copy constants from mx2x.h to mx21.h using the appropriate namespace
      imx: copy constants from mx2x.h to mx27.h using the appropriate namespace
      imx: copy constants from mx3x.h to mx31.h using the appropriate namespace
      imx: copy constants from mx3x.h to mx35.h using the appropriate namespace

Valentin Longchamp (9):
      mx31: various pins used for mx31moboard
      mx31moboard: serial port fix
      mx31moboard: support for pin linked for battery presence check
      mx31moboard: SPI and MC13783 voltage regulator support
      mx31moboard: initialize ipu device for all the boards
      mx31moboard: camera support
      mx31: pins used for mx31moboard USB
      mx31moboard: SPI corrections
      mx31moboard: support for usbh1 and usbh2

 arch/arm/mach-mx2/Kconfig                       |    2 +
 arch/arm/mach-mx2/clock_imx27.c                 |    4 +-
 arch/arm/mach-mx2/devices.c                     |   78 +++++
 arch/arm/mach-mx2/devices.h                     |    3 +-
 arch/arm/mach-mx2/pca100.c                      |    2 +-
 arch/arm/mach-mx3/Kconfig                       |    3 +
 arch/arm/mach-mx3/Makefile                      |    4 +-
 arch/arm/mach-mx3/armadillo5x0.c                |   60 ++++-
 arch/arm/mach-mx3/clock-imx35.c                 |   41 ++-
 arch/arm/mach-mx3/clock.c                       |    6 +-
 arch/arm/mach-mx3/cpu.c                         |   57 +++
 arch/arm/mach-mx3/devices.c                     |   44 +++-
 arch/arm/mach-mx3/devices.h                     |    2 +
 arch/arm/mach-mx3/mx31lilly-db.c                |   10 +
 arch/arm/mach-mx3/mx31lilly.c                   |   57 +++-
 arch/arm/mach-mx3/mx31lite-db.c                 |  198 +++++++++++
 arch/arm/mach-mx3/mx31lite.c                    |  175 +++++++++--
 arch/arm/mach-mx3/mx31moboard-devboard.c        |   86 +++++
 arch/arm/mach-mx3/mx31moboard-marxbot.c         |  192 +++++++++++-
 arch/arm/mach-mx3/mx31moboard.c                 |  249 +++++++++++++-
 arch/arm/mach-mx3/pcm043.c                      |    7 +
 arch/arm/plat-mxc/Kconfig                       |   10 +
 arch/arm/plat-mxc/Makefile                      |    3 +
 arch/arm/plat-mxc/audmux-v1.c                   |   53 +++
 arch/arm/plat-mxc/audmux-v2.c                   |   74 ++++
 arch/arm/plat-mxc/dma-mx1-mx2.c                 |    3 +-
 arch/arm/plat-mxc/gpio.c                        |    2 +-
 arch/arm/plat-mxc/include/mach/audmux.h         |   52 +++
 arch/arm/plat-mxc/include/mach/board-mx31lite.h |   39 ++-
 arch/arm/plat-mxc/include/mach/dma-mx1-mx2.h    |    8 +
 arch/arm/plat-mxc/include/mach/iomux-mx3.h      |   26 ++-
 arch/arm/plat-mxc/include/mach/iomux-v3.h       |   17 +-
 arch/arm/plat-mxc/include/mach/mx21.h           |  207 ++++++++++--
 arch/arm/plat-mxc/include/mach/mx25.h           |   10 +-
 arch/arm/plat-mxc/include/mach/mx27.h           |  315 +++++++++++++----
 arch/arm/plat-mxc/include/mach/mx2x.h           |  339 ++++++++++++-------
 arch/arm/plat-mxc/include/mach/mx31.h           |  237 +++++++++++--
 arch/arm/plat-mxc/include/mach/mx35.h           |  201 ++++++++++-
 arch/arm/plat-mxc/include/mach/mx3x.h           |  418 +++++++++++++++--------
 arch/arm/plat-mxc/include/mach/ulpi.h           |    7 +
 arch/arm/plat-mxc/include/mach/uncompress.h     |    2 +
 arch/arm/plat-mxc/iomux-v3.c                    |   36 +--
 arch/arm/plat-mxc/ulpi.c                        |  113 ++++++
 43 files changed, 2933 insertions(+), 519 deletions(-)
 create mode 100644 arch/arm/mach-mx3/cpu.c
 create mode 100644 arch/arm/mach-mx3/mx31lite-db.c
 create mode 100644 arch/arm/plat-mxc/audmux-v1.c
 create mode 100644 arch/arm/plat-mxc/audmux-v2.c
 create mode 100644 arch/arm/plat-mxc/include/mach/audmux.h
 create mode 100644 arch/arm/plat-mxc/include/mach/ulpi.h
 create mode 100644 arch/arm/plat-mxc/ulpi.c

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
