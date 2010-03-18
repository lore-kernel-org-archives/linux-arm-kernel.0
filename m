From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Thu, 18 Mar 2010 18:59:59 +0200
Subject: [PATCH v2 0/3] spi: driver for Cirrus EP93xx SPI controller
Message-ID: <cover.1268930557.git.mika.westerberg@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is second, updated revision of the series. I tried to address all the
review comments given by H Hartley Sweeten, Ryan Mallon and Martin Guy.

I also tested these again with my TS-7260 board (it has EP9302 chip) using at25
and mmc_spi drivers.

Please review.

Thanks,
MW

Mika Westerberg (3):
  spi: implemented driver for Cirrus EP93xx SPI controller
  ep93xx: added chip revision reading function
  ep93xx: SPI driver platform support code

 arch/arm/mach-ep93xx/clock.c                    |   14 +
 arch/arm/mach-ep93xx/core.c                     |   56 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    1 +
 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h  |   34 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |   10 +
 drivers/spi/Kconfig                             |   11 +
 drivers/spi/Makefile                            |    1 +
 drivers/spi/ep93xx_spi.c                        | 1063 +++++++++++++++++++++++
 8 files changed, 1190 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
 create mode 100644 drivers/spi/ep93xx_spi.c
