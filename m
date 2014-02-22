From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 22:35:52 +0100
Subject: [PATCH 0/7] Add Allwinner A10 SPI Controller Driver
Message-ID: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset brings support for the SPI controller found in the
Allwinner A10 and derived SoCs.

Even though the controller supports DMA, the driver only supports PIO
mode for now. This driver will be used to bring up and test DMA on the
SoC, so support for the DMA will come eventually.

It doesn't support transfer larger than the FIFO size (64 bytes) for
now, It's one of the things that will be fixed whenever we will have
DMA support.

Thanks!
Maxime

Maxime Ripard (7):
  spi: sunxi: Add Allwinner A10 SPI controller driver
  ARM: dt: sun7i: Add A20 SPI controller nodes
  ARM: dt: sun4i: Add A10 SPI controller nodes
  ARM: dt: sun5i: Add A10s SPI controller nodes
  ARM: dt: sun5i: Add A13 SPI controller nodes
  ARM: dt: sun7i: Add SPI muxing options
  ARM: dts: sun7i: Enable the SPI controllers of the A20-olinuxino-micro

 .../devicetree/bindings/spi/spi-sun4i.txt          |  24 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                   |  44 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  33 ++
 arch/arm/boot/dts/sun5i-a13.dtsi                   |  33 ++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |  17 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  58 +++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sun4i.c                            | 477 +++++++++++++++++++++
 9 files changed, 693 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sun4i.txt
 create mode 100644 drivers/spi/spi-sun4i.c

-- 
1.9.0
