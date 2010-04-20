From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Tue, 20 Apr 2010 18:11:34 +0300
Subject: [PATCH v4 0/2] spi: driver for Cirrus EP93xx SPI controller
Message-ID: <cover.1271774845.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is fourth iteration of the driver. I tried to address most of the review
comments I received.

Changes to previous version:
	- dropped polling mode, there is no real use for that
	- changes according review comments by Grant Likely, Martin Guy,
	  and H. Hartley Sweeten

Previous version can be found here (with review comments):
	http://lists.infradead.org/pipermail/linux-arm-kernel/2010-April/012941.html

Let's hope I didn't forget anything.

Tested with my TS-7260 board with mmc_spi and at25 drivers.

Note that patch 2/2 depends on patch that is already in Russell's patch
tracking system:
	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5998/1

Thanks,
MW

Mika Westerberg (2):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: SPI driver platform support code

 arch/arm/mach-ep93xx/clock.c                    |   14 +
 arch/arm/mach-ep93xx/core.c                     |   48 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   32 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |    2 +
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        |  992 +++++++++++++++++++++++
 8 files changed, 1101 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c
