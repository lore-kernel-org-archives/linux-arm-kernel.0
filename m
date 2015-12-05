From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Sat,  5 Dec 2015 17:56:58 +0100
Subject: [PATCH v5 00/11] Improvements for SPI IMX driver for Freescale IMX51,
 IMX53 and IMX6
Message-ID: <1449334629-4715-1-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of patches to impove or add the implementation
for the spi-imx driver related to Freescale IMX51, IMX53 and IMX6.
It would also possible some of patches can be applied for other
Freescale controllers using spi-imx driver but could not be tested
due to lack of hardware.

Changes since V4:
 * Split [PATCH v4 01] into several smaller commits
 * Change [PATCH v4 01] into workaround to disable DMA for transfer which len mod WML
not equal 0
 * Rework some patches to isolate changes in one place

Anton Bondarenko (11):
  spi: imx: terminate RX DMA transaction in case of TX DMA timeout
  spi: imx: reorder HW operations enable order to avoid possible RX data
    loss
  spi: imx: replace multiple watermarks with single for RX, TX and RXT
  spi: imx: add function to check for IMX51 family controller
  spi: imx: Add support for loopback for ECSPI controllers
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is
  spi: imx: allow only WML aligned transfers to use DMA
  spi: imx: remove dead RX DMA tail handling code
  spi: imx: replace fixed timeout with calculated
  spi: imx: add support for all SPI word width for DMA

 drivers/spi/spi-imx.c | 249 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 179 insertions(+), 70 deletions(-)

-- 
2.6.3
