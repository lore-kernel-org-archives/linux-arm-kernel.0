From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 16 Jan 2014 18:11:21 +0100
Subject: [PATCH 0/4] Add Allwinner A31 SPI controller support
Message-ID: <1389892285-11745-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset brings support for the SPI controller found in the
Allwinner A31 SoC.

Even though the controller supports DMA, the driver only supports PIO
mode for now. This driver will be used to bring up and test DMA on the
SoC, so support for the DMA will come eventually.

It doesn't support transfer larger than the FIFO size (128 bytes) for
now, so this is kind of a blocker against inclusion, but I expect it
to be fixed by v2.

Thanks!
Maxime

Maxime Ripard (4):
  clk: sunxi: Add support for PLL6 on the A31
  ARM: sun6i: dt: Add PLL6 and SPI module clocks
  spi: sunxi: Add Allwinner A31 SPI controller driver
  ARM: sun6i: dt: Add SPI controllers to the A31 DTSI

 Documentation/devicetree/bindings/clock/sunxi.txt  |   1 +
 .../devicetree/bindings/spi/spi-sun6i.txt          |  23 +
 arch/arm/boot/dts/sun6i-a31.dtsi                   |  88 +++-
 drivers/clk/sunxi/clk-sunxi.c                      |  45 ++
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-sun6i.c                            | 463 +++++++++++++++++++++
 6 files changed, 611 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-sun6i.txt
 create mode 100644 drivers/spi/spi-sun6i.c

-- 
1.8.4.2
