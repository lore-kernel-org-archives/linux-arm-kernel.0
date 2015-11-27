From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat, 28 Nov 2015 00:15:58 +0100
Subject: [PATCH v4 0/7]  Improvements for SPI IMX driver for Freescale IMX51,
 IMX53 and IMX6
Message-ID: <1448666165-7473-1-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of patches to impove or add the implementation
for the spi-imx driver related to Freescale IMX51, IMX53 and IMX6.
It would also possible some of patches can be applied for other
Freescale controllers using spi-imx driver but could not be tested
due to lack of hardware.

Changes since V3:
 Addressed comments from V3 review, simplified timeout calculation

Anton Bondarenko (7):
  spi: imx: Fix DMA transfer
  spi: imx: replace fixed timeout with calculated one
  spi: imx: add support for all SPI word width for DMA transfer
  spi: imx: add function to check for IMX51 family controller
  spi: imx: Add support for loopback for ECSPI controllers
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is pending

 drivers/spi/spi-imx.c | 320 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 237 insertions(+), 83 deletions(-)

-- 
2.6.3
