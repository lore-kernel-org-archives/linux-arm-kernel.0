From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 30 Nov 2016 10:43:46 +0100
Subject: [PATCH v2 0/5] Add support for the Armada 3700 SPI controller
Message-ID: <20161130094351.2748-1-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell Armada 3700 SoC includes an SPI controller. This controller
supports up to 4 SPI slave devices, with dedicated chip selects, CPIO or
FIFO mode with DMA or CPU transfers and different SPI transfer modes
(Standard single, Dual or Quad).

This set of patches adds a basic support for the CPIO mode, then it
enables the FIFO mode (CPU-side only, DMA not supported yet). It also
adds the required definitions of the spi nodes to the devicetree.

Romain Perier (5):
  spi: Add basic support for Armada 3700 SPI Controller
  spi: armada-3700: Add support for the FIFO mode
  dt-bindings: spi: Add documentation for the Armada 3700 SPI Controller
  arm64: dts: marvell: Add definition of SPI controller for Armada 3700
  arm64: dts: marvell: Enable spi0 on the board Armada-3720-db

 .../devicetree/bindings/spi/spi-armada-3700.txt    |   25 +
 arch/arm64/boot/dts/marvell/armada-3720-db.dts     |   30 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi       |   13 +
 drivers/spi/Kconfig                                |    7 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-armada-3700.c                      | 1040 ++++++++++++++++++++
 6 files changed, 1116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-armada-3700.txt
 create mode 100644 drivers/spi/spi-armada-3700.c

-- 
2.9.3
