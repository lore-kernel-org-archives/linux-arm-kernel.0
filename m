From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 11 Oct 2010 16:40:19 +0200
Subject: Pull request for next
Message-ID: <20101011144019.GA28242@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Russell,

Please pull the following i.MX related changes for the next merge
window.

Sascha


The following changes since commit 7c6d45e665d5322401e4439060bbf758b08422d4:

  powerpc: remove unused variable (2010-10-05 17:27:54 -0700)

are available in the git repository at:
  git://git.pengutronix.de/git/imx/linux-2.6.git for-rmk-next

Amit Kucheria (2):
      mx51: add support for genesi efikamx nettop
      mx51: efikamx: add otg support

David Jander (1):
      spi/imx: Support different fifo sizes

Eric B?nard (5):
      mach-cpuimx35: remove unecessary tsc2007 functions + style cleanup
      eukrea_mbimxsd for cpuimx35: add CAN & SDCard support
      i.mx25: add esdhc support
      eukrea_mbimxsd for cpuimx25: add CAN & SDCard support
      ARM: mx35: Add mx35_revision function to query the silicon revision

Fabio Estevam (1):
      ARM: mx5/mx51_babbage: Add FEC support

Jason Wang (4):
      ARM: mx5/clock-mx51: add spi clocks
      ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on the imx51_3ds board
      ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds board
      ARM: mx5/mx51_3ds: add SPI NOR flash in the board init stage

Javier Martin (1):
      ARM: imx: Add support for Vista Silicon Visstrim_m10 board

Juergen Beisert (1):
      MX35: Fix bogus L2 cache settings

Marc Kleine-Budde (4):
      ARM: mx3/mx35_3ds: add physmap-flash NOR at CS0
      ARM: mx3/mx35_3ds: add NAND flash
      ARM: mx3/mx35_3ds: rename usb otg platform data variable name
      ARM: mx3/mx35_3ds: add usb host2 support

Peter Korsgaard (1):
      mxc/gpio: make _set_value work with values != 0/1

Sascha Hauer (13):
      ARM: imx: Add EPIT support
      ARM: mx3/imx35: Add EPIT support
      ARM: mx5/mx51_babbage: fix compiler warnings
      ARM: mx5/iomux-mx51: Add SPI controller pads
      ARM: mx5/iomux-mx51: Add aud3 primary function defines
      ARM: mx5/iomux-mx51: Fix input path of some pins in gpio mode
      ARM: mx5: Add Nand clock support
      ARM: mx51: add imx-ssi devices
      ARM: mx51: Add audmux support
      ARM: mx5: dynamically register mxc-nand device
      ARM: mx5: clock-imx51: make *ipg clocks secondary clocks of their corresponding peripheral clocks
      ARM: mx3: use MX3x_ prefixed version of CHIP_REV_x
      ARM: iomux-mx51: Add AUD5 pinmux definitions

Uwe Kleine-K?nig (35):
      ARM: imx: remove #ifdefery for unmerged flexcan driver
      ARM: imx: ehci: use void __iomem * to hold i/o addresses
      ARM: mx5/mx51_babbage: don't use PHYS_OFFSET
      ARM: mx27_defconfig: enable switches used in mx27 code
      ARM: mx3_defconfig: add new machine MACH_EUKREA_CPUIMX35
      ARM: remove mx31pdk_defconfig
      ARM: mx51_defconfig: add new boards MACH_MX51_3DS and MACH_EUKREA_CPUIMX51
      ARM: mx51: clean up mx51 header
      ARM: mx51: fix naming of spi related defines
      ARM: mx51: use IMX_IO_ADDRESS to define MX51_IO_ADDRESS
      ARM: imx: change the way spi-imx devices are registered
      ARM: imx: change the way imx-uarts are registered
      ARM: imx: dynamically allocate imx-ssi devices
      ARM: imx: reorganize imx-i2c device registration to use a struct per SoC
      ARM: mx5: dynamically register imx-i2c devices
      ARM: imx: fix name of macros to add imx-i2c devices
      spi/imx: default to m on platforms that have such devices
      spi/imx: convert driver to use platform ids
      spi/imx: get rid of more ifs depending on the used cpu
      spi/imx: save the spi chip select in config struct, not the gpio to use
      spi/imx: add support for imx51's eCSPI and CSPI
      ARM: imx: use platform ids for spi_imx devices
      ARM: mx5: add spi_imx device registration
      ARM: mx5/clock-mx51: refactor ccgr callbacks to use common code
      ARM: mx5/clock-mx51: new macro that defines a clk with all members
      ARM: mx51: dynamically register imx-uart devices
      ARM: imx: reorganize nand registration to use a struct
      ARM: imx/clock-imx27: Pass NULL as function callback, not 0
      ARM: imx/pcm038: make regulator platform data static
      ARM: imx: make all pin lists const and signed, move to .init where possible
      ARM: imx/pcm970: make platform_data static
      ARM: imx/pca100: only specify i2c device type once
      ARM: imx: fix/define clocks and create devices for imx dma
      ARM: imx: dynamically register fec devices
      ARM: mx3/cpuimx35: mark otg_pdata and usbh1_pdata as maybe unused

Wolfram Sang (4):
      arm: imx: add generic esdhc device
      arm: imx35: add esdhc-device to MX35-platform
      arm: pcm043: add esdhc-device to boardconfig
      mx25/clocks: match esdhc-clocks to platform device

 arch/arm/configs/mx27_defconfig                 |   15 +-
 arch/arm/configs/mx31pdk_defconfig              |   44 --
 arch/arm/configs/mx3_defconfig                  |    2 +-
 arch/arm/configs/mx51_defconfig                 |    9 +-
 arch/arm/mach-imx/Kconfig                       |   14 +-
 arch/arm/mach-imx/Makefile                      |    1 +
 arch/arm/mach-imx/clock-imx1.c                  |    2 +-
 arch/arm/mach-imx/clock-imx21.c                 |    6 +-
 arch/arm/mach-imx/clock-imx27.c                 |   48 +-
 arch/arm/mach-imx/devices-imx1.h                |   14 +-
 arch/arm/mach-imx/devices-imx21.h               |   36 +-
 arch/arm/mach-imx/devices-imx27.h               |   51 +-
 arch/arm/mach-imx/devices.c                     |   56 --
 arch/arm/mach-imx/devices.h                     |    3 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    8 +-
 arch/arm/mach-imx/mach-cpuimx27.c               |    6 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |  263 +++++++++
 arch/arm/mach-imx/mach-imx27lite.c              |    8 +-
 arch/arm/mach-imx/mach-mx1ads.c                 |    4 +-
 arch/arm/mach-imx/mach-mx21ads.c                |    2 +-
 arch/arm/mach-imx/mach-mx27_3ds.c               |    8 +-
 arch/arm/mach-imx/mach-mx27ads.c                |    6 +-
 arch/arm/mach-imx/mach-mxt_td60.c               |   13 +-
 arch/arm/mach-imx/mach-pca100.c                 |   15 +-
 arch/arm/mach-imx/mach-pcm038.c                 |    8 +-
 arch/arm/mach-imx/mach-scb9328.c                |    2 +-
 arch/arm/mach-imx/pcm970-baseboard.c            |    4 +-
 arch/arm/mach-mx25/Kconfig                      |    6 +-
 arch/arm/mach-mx25/clock.c                      |   28 +-
 arch/arm/mach-mx25/devices-imx25.h              |   62 ++-
 arch/arm/mach-mx25/devices.c                    |   58 --
 arch/arm/mach-mx25/devices.h                    |    3 -
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c   |   12 +-
 arch/arm/mach-mx25/mach-cpuimx25.c              |    5 +-
 arch/arm/mach-mx25/mach-mx25_3ds.c              |    5 +-
 arch/arm/mach-mx3/Kconfig                       |   11 +-
 arch/arm/mach-mx3/Makefile                      |    1 -
 arch/arm/mach-mx3/clock-imx31.c                 |   10 +-
 arch/arm/mach-mx3/clock-imx35.c                 |   28 +-
 arch/arm/mach-mx3/cpu.c                         |   47 ++-
 arch/arm/mach-mx3/devices-imx31.h               |   49 +-
 arch/arm/mach-mx3/devices-imx35.h               |   51 ++-
 arch/arm/mach-mx3/devices.c                     |   63 ---
 arch/arm/mach-mx3/devices.h                     |    4 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c    |   19 +-
 arch/arm/mach-mx3/mach-cpuimx35.c               |   38 +-
 arch/arm/mach-mx3/mach-mx31ads.c                |    2 +-
 arch/arm/mach-mx3/mach-mx35_3ds.c               |   51 ++-
 arch/arm/mach-mx3/mach-pcm043.c                 |   15 +-
 arch/arm/mach-mx3/mm.c                          |   18 +
 arch/arm/mach-mx5/Kconfig                       |   14 +
 arch/arm/mach-mx5/Makefile                      |    1 +
 arch/arm/mach-mx5/board-cpuimx51.c              |   14 +-
 arch/arm/mach-mx5/board-mx51_3ds.c              |   42 ++-
 arch/arm/mach-mx5/board-mx51_babbage.c          |   72 ++-
 arch/arm/mach-mx5/board-mx51_efikamx.c          |  121 +++++
 arch/arm/mach-mx5/clock-mx51.c                  |  231 +++++++-
 arch/arm/mach-mx5/devices-imx51.h               |   38 ++
 arch/arm/mach-mx5/devices.c                     |  114 ----
 arch/arm/mach-mx5/devices.h                     |    6 -
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c    |    7 +-
 arch/arm/plat-mxc/Kconfig                       |   12 +
 arch/arm/plat-mxc/Makefile                      |    1 +
 arch/arm/plat-mxc/audmux-v2.c                   |    8 +-
 arch/arm/plat-mxc/devices/Kconfig               |   10 +
 arch/arm/plat-mxc/devices/Makefile              |    9 +-
 arch/arm/plat-mxc/devices/platform-esdhc.c      |   31 ++
 arch/arm/plat-mxc/devices/platform-fec.c        |   58 ++
 arch/arm/plat-mxc/devices/platform-imx-dma.c    |  129 +++++
 arch/arm/plat-mxc/devices/platform-imx-i2c.c    |   84 +++-
 arch/arm/plat-mxc/devices/platform-imx-ssi.c    |  107 ++++
 arch/arm/plat-mxc/devices/platform-imx-uart.c   |  137 ++++-
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   85 +++-
 arch/arm/plat-mxc/devices/platform-spi_imx.c    |   89 +++-
 arch/arm/plat-mxc/ehci.c                        |    4 +-
 arch/arm/plat-mxc/epit.c                        |  242 +++++++++
 arch/arm/plat-mxc/gpio.c                        |    2 +-
 arch/arm/plat-mxc/include/mach/common.h         |    1 +
 arch/arm/plat-mxc/include/mach/devices-common.h |  108 +++-
 arch/arm/plat-mxc/include/mach/esdhc.h          |   16 +
 arch/arm/plat-mxc/include/mach/iomux-mx51.h     |   61 ++-
 arch/arm/plat-mxc/include/mach/mx21.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx25.h           |   15 +-
 arch/arm/plat-mxc/include/mach/mx27.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx31.h           |   11 +-
 arch/arm/plat-mxc/include/mach/mx35.h           |   32 +-
 arch/arm/plat-mxc/include/mach/mx3x.h           |   23 +-
 arch/arm/plat-mxc/include/mach/mx51.h           |  657 +++++++++++------------
 drivers/spi/Kconfig                             |   16 +
 drivers/spi/spi_imx.c                           |  402 ++++++++++++---
 90 files changed, 3003 insertions(+), 1245 deletions(-)
 delete mode 100644 arch/arm/configs/mx31pdk_defconfig
 create mode 100644 arch/arm/mach-imx/mach-imx27_visstrim_m10.c
 create mode 100644 arch/arm/mach-mx5/board-mx51_efikamx.c
 create mode 100644 arch/arm/mach-mx5/devices-imx51.h
 create mode 100644 arch/arm/plat-mxc/devices/platform-esdhc.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-fec.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-dma.c
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-ssi.c
 create mode 100644 arch/arm/plat-mxc/epit.c
 create mode 100644 arch/arm/plat-mxc/include/mach/esdhc.h
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
