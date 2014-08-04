From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon,  4 Aug 2014 17:09:54 -0300
Subject: [PATCH v3 0/8] DMAEngine support for sun4i, sun5i & sun7i
Message-ID: <1407183002-29420-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

As part of Google Summer of Code, I've tasked myself with implementing
DMA support for the earlier Allwinner platforms. This third round of
patches is the result of said effort.

The first patch is the actual driver to support these platforms. Patches
three, four and five add the corresponding DMA node to the sun4i, sun5i
and sun7i device trees.

The second patch, involving the sunxi SPI driver, lets users do SPI
transfers of >=64 bytes by using DMA. Patches six, seven and eight add
the DMA properties to SPI so the first two patches can be used.

All comments and reviews are welcome :)

Thanks!

Emilio

Emilio L?pez (8):
  dma: sun4i: Add support for the DMA engine on sun[457]i SoCs
  spi: sun4i: add DMA support
  ARM: sun4i: dt: Add node to represent the DMA controller
  ARM: sun5i: dt: Add nodes to represent the DMA controllers
  ARM: sun7i: dt: Add node to represent the DMA controller
  ARM: sun4i: dt: enable DMA on SPI
  ARM: sun5i: dt: enable DMA on SPI
  ARM: sun7i: dt: enable DMA on SPI

 .../devicetree/bindings/dma/sun4i-dma.txt          |   46 +
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   16 +
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |   14 +
 arch/arm/boot/dts/sun5i-a13.dtsi                   |   14 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   16 +
 drivers/dma/Kconfig                                |   11 +
 drivers/dma/Makefile                               |    1 +
 drivers/dma/sun4i-dma.c                            | 1238 ++++++++++++++++++++
 drivers/spi/spi-sun4i.c                            |  155 ++-
 9 files changed, 1500 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/sun4i-dma.txt
 create mode 100644 drivers/dma/sun4i-dma.c

-- 
2.0.4
