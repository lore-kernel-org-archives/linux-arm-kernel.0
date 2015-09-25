From: anton_bondarenko@mentor.com (Anton Bondarenko)
Date: Fri, 25 Sep 2015 19:57:07 +0200
Subject: [PATCH v2 0/8] Improvements for SPI IMX driver for Freescale IMX53
 and IMX6 families
Message-ID: <cover.1442923630.git.anton_bondarenko@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of patches to impove or add the implementation
for the spi-imx driver related to Freescale IMX53 and IMX6.
It would also possible some of patches can be applied for other
Freescale controllers using spi-imx driver but could not be tested
due to lack of hardware.

Anton Bondarenko (8):
  spi: imx: Fix DMA transfer
  spi: imx: replace fixed timeout with calculated one
  spi: imx: add support for all SPI word width for DMA transfer
  spi: imx: add selection for iMX53 and iMX6 controller type
  spi: imx: Add support for loopback for ECSPI controllers
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is pending
  spi: imx: Add support for SPI Slave mode for imx53 and imx6 chips

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       |   3 +
 drivers/spi/spi-imx.c                              | 486 ++++++++++++++++-----
 2 files changed, 388 insertions(+), 101 deletions(-)

-- 
2.5.2
