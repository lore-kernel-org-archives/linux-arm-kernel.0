From: hramrach@gmail.com (Michal Suchanek)
Date: Thu, 20 Aug 2015 16:15:22 +0200
Subject: [PATCH 0/9] spi/sunxi patches
Message-ID: <cover.1440080122.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Since the sun4i dmaengine and DT label conversion patches are in this should be
now workable.

 - fix some minor issues with the spi driver
 - add spi dt nodes on some boards
 - include the DMA patch which depends on the dmaengine

Thanks

Michal

Emilio L?pez (1):
  spi: sun4i: add DMA support

Michal Suchanek (8):
  spi: sunxi: fix transfer timeout
  spi: sun4i: fix FIFO limit
  spi: sunxi: check that transfer speed is non-zero
  ARM: dts: sun7i: cubieboard2: Enable SPI0
  ARM: dts: sunxi: add spi aliases on cubieboards
  ARM: dts: sun5i: add SPI pins on A13 and A10s
  ARM: dts: sunxi: A10s Olinuxino Micro: add spi2.
  ARM: dts: sunxi: Add SPI aliases on A10s Olinuxino.

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |   1 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  10 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  21 +++
 arch/arm/boot/dts/sun5i.dtsi                     |  49 +++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |   8 ++
 drivers/spi/spi-sun4i.c                          | 166 ++++++++++++++++++++---
 drivers/spi/spi-sun6i.c                          |  25 +++-
 7 files changed, 257 insertions(+), 23 deletions(-)

-- 
2.1.4
