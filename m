From: richard.genoud@gmail.com (Richard Genoud)
Date: Tue, 14 Aug 2012 15:49:24 +0200
Subject: [PATCH 10/23] spi-atmel: update with dmaengine interface
In-Reply-To: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
References: <1344952177-18385-1-git-send-email-richard.genoud@gmail.com>
Message-ID: <1344952177-18385-11-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 185ecb5f4fd43911c35956d4cc7d94a1da30417f changed dmaengine
interface.
=> we have to update spi-atmel accordingly

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 drivers/spi/spi-atmel.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 9456fca..48bf3bc 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -542,7 +542,8 @@ static int atmel_spi_next_xfer_dma(struct spi_master *master,
 					&as->dma.sgrx,
 					1,
 					DMA_FROM_DEVICE,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					NULL);
 	if (!rxdesc)
 		goto err_dma;
 
@@ -550,7 +551,8 @@ static int atmel_spi_next_xfer_dma(struct spi_master *master,
 					&as->dma.sgtx,
 					1,
 					DMA_TO_DEVICE,
-					DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
+					NULL);
 	if (!txdesc)
 		goto err_dma;
 
-- 
1.7.2.5
