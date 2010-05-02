From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sun,  2 May 2010 17:38:58 +0300
Subject: [PATCH v6 0/2] spi: driver for Cirrus EP93xx SPI controller
Message-ID: <cover.1272805161.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series implements SPI master driver for Cirrus Logic EP93xx SPI
controllers.

This is sixth iteration of the driver.

Changes to the previous version:
	- addressed most review comments by H. Hartley Sweeten
	- incorporated GPIO chipselect patch by H. Hartley Sweeten

I tested this on TS-7260 board with at25 and mmc_spi drivers. Now that I have
Sim.One board, which is EP9307 based, I also tested with that (I hacked the
board a bit to get EGPIO9 as a chip select).

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system:
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1

Thanks,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 Documentation/spi/ep93xx_spi                    |   95 +++
 arch/arm/mach-ep93xx/clock.c                    |   13 +
 arch/arm/mach-ep93xx/core.c                     |   53 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   27 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    4 +
 drivers/spi/Kconfig                             |   10 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        |  986 +++++++++++++++++++++++
 9 files changed, 1190 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/ep93xx_spi
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c
