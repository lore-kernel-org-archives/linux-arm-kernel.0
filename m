From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 27 Sep 2010 15:50:09 +0200
Subject: imx patches for 2.6.37
Message-ID: <20100927135009.GC6271@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

here is my patch stack of imx patches for 2.6.37.  I rebased Sascha's
current imx-for-2.6.37 branch on 2.6.36-rc4 to fix some conflicts in my
patches as imx-for-2.6.37 didn't contain some imx patches already in
mainline.  The series contains five patches to drivers/spi, they were
acked by Grant Likely and he's OK with them going via Sascha's tree.

I send all patches that are not in Sascha's for-2.6.37 branch as reply
to this mail even if some of them might already have been seen here, to
have them all in place.

The following changes since commit 3efee47db7a191443b529740b35240d63ae1ad20:

  ARM: mx5/mx51_babbage: Add FEC support (2010-09-27 12:53:00 +0200)

are available in the git repository at:
  git://git.pengutronix.de/git/ukl/linux-2.6.git imx/for-2.6.37

Jason Wang (4):
      ARM: mx5/clock-mx51: add spi clocks
      ARM: mx5/iomux-mx51: add iomux definitions for eCSPI2 on the imx51_3ds board
      ARM: mx5/mx51_3ds: add eCSPI2 support on the imx51_3ds board
      ARM: mx5/mx51_3ds: add SPI NOR flash in the board init stage

Sascha Hauer (9):
      ARM: mx5/mx51_babbage: fix compiler warnings
      ARM: mx5/iomux-mx51: Add SPI controller pads
      ARM: mx5/iomux-mx51: Add aud3 primary function defines
      ARM: mx5/iomux-mx51: Fix input path of some pins in gpio mode
      ARM: mx5: Add Nand clock support
      ARM: mx51: add imx-ssi devices
      ARM: mx51: Add audmux support
      ARM: mx5: dynamically register mxc-nand device
      ARM: mx5: clock-imx51: make *ipg clocks secondary clocks of their corresponding peripheral clocks

Uwe Kleine-K?nig (27):
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

 arch/arm/configs/mx27_defconfig                 |   15 +-
 arch/arm/configs/mx31pdk_defconfig              |   44 --
 arch/arm/configs/mx3_defconfig                  |    2 +-
 arch/arm/configs/mx51_defconfig                 |    9 +-
 arch/arm/mach-imx/Kconfig                       |    5 +-
 arch/arm/mach-imx/clock-imx1.c                  |    2 +-
 arch/arm/mach-imx/clock-imx21.c                 |    6 +-
 arch/arm/mach-imx/clock-imx27.c                 |    6 +-
 arch/arm/mach-imx/devices-imx1.h                |   14 +-
 arch/arm/mach-imx/devices-imx21.h               |   36 +-
 arch/arm/mach-imx/devices-imx27.h               |   47 +-
 arch/arm/mach-imx/devices.c                     |   35 --
 arch/arm/mach-imx/devices.h                     |    2 -
 arch/arm/mach-imx/eukrea_mbimx27-baseboard.c    |    6 +-
 arch/arm/mach-imx/mach-cpuimx27.c               |    2 +-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |    4 +-
 arch/arm/mach-imx/mach-mx1ads.c                 |    2 +-
 arch/arm/mach-imx/mach-mx27ads.c                |    2 +-
 arch/arm/mach-imx/mach-mxt_td60.c               |    4 +-
 arch/arm/mach-imx/mach-pca100.c                 |    7 +-
 arch/arm/mach-imx/mach-pcm038.c                 |    2 +-
 arch/arm/mach-mx25/Kconfig                      |    4 +-
 arch/arm/mach-mx25/clock.c                      |    6 +-
 arch/arm/mach-mx25/devices-imx25.h              |   49 +-
 arch/arm/mach-mx25/devices.c                    |   38 --
 arch/arm/mach-mx25/devices.h                    |    2 -
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c   |    6 +-
 arch/arm/mach-mx3/Kconfig                       |    6 +-
 arch/arm/mach-mx3/clock-imx31.c                 |    6 +-
 arch/arm/mach-mx3/clock-imx35.c                 |    4 +-
 arch/arm/mach-mx3/devices-imx31.h               |   49 +-
 arch/arm/mach-mx3/devices-imx35.h               |   40 +-
 arch/arm/mach-mx3/devices.c                     |   42 --
 arch/arm/mach-mx3/devices.h                     |    3 -
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c    |    6 +-
 arch/arm/mach-mx3/mach-mx31ads.c                |    2 +-
 arch/arm/mach-mx3/mach-pcm043.c                 |    5 +-
 arch/arm/mach-mx5/Kconfig                       |    7 +
 arch/arm/mach-mx5/board-cpuimx51.c              |   12 +-
 arch/arm/mach-mx5/board-mx51_3ds.c              |   42 ++-
 arch/arm/mach-mx5/board-mx51_babbage.c          |   16 +-
 arch/arm/mach-mx5/clock-mx51.c                  |  226 +++++++-
 arch/arm/mach-mx5/devices-imx51.h               |   34 ++
 arch/arm/mach-mx5/devices.c                     |   95 ----
 arch/arm/mach-mx5/devices.h                     |    5 -
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c    |    7 +-
 arch/arm/plat-mxc/audmux-v2.c                   |    8 +-
 arch/arm/plat-mxc/devices/Kconfig               |    3 +
 arch/arm/plat-mxc/devices/Makefile              |    6 +-
 arch/arm/plat-mxc/devices/platform-imx-i2c.c    |   84 +++-
 arch/arm/plat-mxc/devices/platform-imx-ssi.c    |  107 ++++
 arch/arm/plat-mxc/devices/platform-imx-uart.c   |  137 ++++-
 arch/arm/plat-mxc/devices/platform-mxc_nand.c   |   85 +++-
 arch/arm/plat-mxc/devices/platform-spi_imx.c    |   89 +++-
 arch/arm/plat-mxc/ehci.c                        |    4 +-
 arch/arm/plat-mxc/include/mach/devices-common.h |   93 +++-
 arch/arm/plat-mxc/include/mach/iomux-mx51.h     |   33 +-
 arch/arm/plat-mxc/include/mach/mx21.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx25.h           |   11 +-
 arch/arm/plat-mxc/include/mach/mx27.h           |    2 +-
 arch/arm/plat-mxc/include/mach/mx31.h           |   11 +-
 arch/arm/plat-mxc/include/mach/mx35.h           |   11 +-
 arch/arm/plat-mxc/include/mach/mx51.h           |  657 +++++++++++------------
 drivers/spi/Kconfig                             |   16 +
 drivers/spi/spi_imx.c                           |  394 +++++++++++---
 65 files changed, 1716 insertions(+), 1001 deletions(-)
 delete mode 100644 arch/arm/configs/mx31pdk_defconfig
 create mode 100644 arch/arm/mach-mx5/devices-imx51.h
 create mode 100644 arch/arm/plat-mxc/devices/platform-imx-ssi.c


-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
