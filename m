From: jiada_wang@mentor.com (Jiada Wang)
Date: Mon, 5 Jun 2017 12:38:05 +0900
Subject: [PATCH linux-next v3 0/4] i.MX ECSPI controller slave mode support
Message-ID: <20170605033809.13726-1-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes in v3:
* renamed several variables for for better readability
* created spi_imx_pio_transfer_slave() for slave pio transfer
* added fifo_size, has_dmamode and has_slavemode in spi_imx_devtype_data

Changes in v2:
* re-workd i.MX ECSPI controller slave mode support based on Geert's work

Jiada Wang (4):
  spi: imx: introduce fifo_size and has_dmamode in spi_imx_devtype_data
  spi: imx: add selection for iMX53 and iMX6 controller
  ARM: dts: imx: change compatiblity for SPI controllers on imx53 later
    soc
  spi: imx: Add support for SPI Slave mode

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   1 +
 arch/arm/boot/dts/imx53.dtsi                       |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                       |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |   8 +-
 arch/arm/boot/dts/imx6sl.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6sx.dtsi                      |   8 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   8 +-
 drivers/spi/spi-imx.c                              | 275 ++++++++++++++++++---
 8 files changed, 257 insertions(+), 57 deletions(-)

-- 
2.9.3
