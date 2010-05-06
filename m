From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu,  6 May 2010 07:47:03 +0300
Subject: [PATCH v7 0/2] spi: driver for Cirrus EP93xx SPI controller
Message-ID: <cover.1273120206.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series implements SPI master driver for Cirrus Logic EP93xx SPI
controllers.

Changes to previous (v6) version:
	- only cosmetic non-functional changes (removed unnecessary comments and
	  few inlines) based on review comments by H Hartley Sweeten

Tested on TS-7260 (ep9302) and Sim.One (ep9307) boards with mmc_spi and at25
drivers.

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system (and in linux-next)
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1
So 2/2 should probably go in via Russell's tree.

Regards,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 Documentation/spi/ep93xx_spi                    |   95 +++
 arch/arm/mach-ep93xx/clock.c                    |   13 +
 arch/arm/mach-ep93xx/core.c                     |   52 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   27 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    4 +
 drivers/spi/Kconfig                             |   10 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        |  938 +++++++++++++++++++++++
 9 files changed, 1141 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/spi/ep93xx_spi
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c
