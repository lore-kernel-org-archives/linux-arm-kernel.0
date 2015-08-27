From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 27 Aug 2015 21:09:04 +0800
Subject: [PATCH] spi: mediatek: fix SPI_CMD_PAUSE_IE macro error
Message-ID: <1440680944-32537-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable pause interrupt should use SPI_CMD_PAUSE_IE MACRO,
so fix it.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index eaadc7e..d882261 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -158,7 +158,7 @@ static void mtk_spi_config(struct mtk_spi *mdata,
 #endif
 
 	/* set finish and pause interrupt always enable */
-	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_EN;
+	reg_val |= SPI_CMD_FINISH_IE | SPI_CMD_PAUSE_IE;
 
 	/* disable dma mode */
 	reg_val &= ~(SPI_CMD_TX_DMA | SPI_CMD_RX_DMA);
-- 
1.8.1.1.dirty
