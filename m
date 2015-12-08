From: anton.bondarenko.sama@gmail.com (Anton Bondarenko)
Date: Tue,  8 Dec 2015 07:43:42 +0100
Subject: [PATCH v6 0/8] Improvements for SPI IMX driver for Freescale ECSPI
 controller, continuation
Message-ID: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is to complement commits already applied to topic/imx branch

Changes since V5:
 * Fix for commit "spi: imx: Add loopback mode support"
 * Addressed some comments from Sascha Hauer for DMA initialization error report
 * Fixed 32 bytes transaction. It will be DMA now.

Anton Bondarenko (8):
  spi: imx: fix loopback mode setup after controller reset
  spi: imx: enable loopback only for ECSPI controller family
  spi: imx: return error from dma channel request
  spi: imx: defer spi initialization, if DMA engine is
  spi: imx: allow only WML aligned transfers to use DMA
  spi: imx: remove dead RX DMA tail handling code
  spi: imx: replace fixed timeout with calculated
  spi: imx: add support for all SPI word width for DMA

 drivers/spi/spi-imx.c | 203 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 145 insertions(+), 58 deletions(-)

-- 
2.6.3
