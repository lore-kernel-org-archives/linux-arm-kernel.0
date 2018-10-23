From: yogeshnarayan.gaur@nxp.com (Yogesh Narayan Gaur)
Date: Tue, 23 Oct 2018 09:37:38 +0000
Subject: [PATCH v3 6/7] spi: nxp-fspi: add octo mode flag bit for octal support
In-Reply-To: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1540287311-1572-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <1540287311-1572-7-git-send-email-yogeshnarayan.gaur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add octo mode flags for octal I/O data transfer support.
NXP FlexSPI controller supports 8 lines Rx/Tx data transfer.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v3:
- Modified string 'octal' with 'octo'.
Changes for v2:
- None

 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 67eea88..332b730 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -993,8 +993,8 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (!ctlr)
 		return -ENOMEM;
 
-	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
-			  SPI_TX_DUAL | SPI_TX_QUAD;
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTO |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTO;
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-- 
2.7.4
