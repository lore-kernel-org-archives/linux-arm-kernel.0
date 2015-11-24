From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 24 Nov 2015 10:51:09 +0100
Subject: [PATCH] dmaengine: at_xdmac: fix false condition for memset_sg
 transfers
Message-ID: <1448358671-4986-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The code was not in agreement with the comments.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: stable at vger.kernel.org # 4.3 and later
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 7f039de..3b68471 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1333,7 +1333,7 @@ at_xdmac_prep_dma_memset_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		 * since we don't care about the stride anymore.
 		 */
 		if ((i == (sg_len - 1)) &&
-		    sg_dma_len(ppsg) == sg_dma_len(psg)) {
+		    sg_dma_len(psg) == sg_dma_len(sg)) {
 			dev_dbg(chan2dev(chan),
 				"%s: desc 0x%p can be merged with desc 0x%p\n",
 				__func__, desc, pdesc);
-- 
2.5.0
