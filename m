From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Jun 2013 17:28:18 +0200
Subject: [PATCH] dmaengine/trivial: at_hdmac: add curly brackets to if/else
 expressions
Message-ID: <1370618898-18296-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct coding style following the patch:
7c407d3e54dcc0c79119553c8d5ef176c1d5bc3a (DMA: AT91:
Get residual bytes in dma buffer).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 50953a7..b321562 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -299,8 +299,9 @@ static int atc_get_bytes_left(struct dma_chan *chan)
 		if (atchan->remain_desc < 0) {
 			ret = -EINVAL;
 			goto out;
-		} else
+		} else {
 			ret = atchan->remain_desc;
+		}
 	} else {
 		/*
 		 * Get residual bytes when current
@@ -1120,8 +1121,9 @@ atc_tx_status(struct dma_chan *chan,
 	if (unlikely(bytes < 0)) {
 		dev_vdbg(chan2dev(chan), "get residual bytes error\n");
 		return DMA_ERROR;
-	} else
+	} else {
 		dma_set_residue(txstate, bytes);
+	}
 
 	dev_vdbg(chan2dev(chan), "tx_status %d: cookie = %d residue = %d\n",
 		 ret, cookie, bytes);
-- 
1.8.2.2
