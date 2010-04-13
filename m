From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 13 Apr 2010 17:10:12 +0300
Subject: [PATCH v3 0/2] spi: driver for Cirrus EP93xx SPI controller
Message-ID: <cover.1271156934.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is third revision of the driver. Thanks to Martin Guy who tested and
reviewed the code.

Changes since v2:
	- corrected spi clock rate calculation
	- interrupt handling is now more efficient
	- driver now supports polling mode as well, this can be selected with
	  'transfer_method' module parameter.
	- controller is disabled in probe function
	- some cosmetic changes

I have been testing this on my TS-7260 board (ep9302 based) with mmc_spi and
at25 drivers.

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system:
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1

Thanks,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 arch/arm/mach-ep93xx/clock.c                    |   14 +
 arch/arm/mach-ep93xx/core.c                     |   42 +
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   34 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    2 +
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        | 1113 +++++++++++++++++++++++
 8 files changed, 1218 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c
