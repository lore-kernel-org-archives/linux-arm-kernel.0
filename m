From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 10 May 2013 15:19:15 +0200
Subject: [PATCH 3/3] dmaengine: at_hdmac/trivial: rearrange CFG register bits
 assignment
In-Reply-To: <042cac60509755c1340d141315a9a8eb1965438a.1368191734.git.nicolas.ferre@atmel.com>
References: <042cac60509755c1340d141315a9a8eb1965438a.1368191734.git.nicolas.ferre@atmel.com>
Message-ID: <c188abd0dbab3af0789d6d35ac37a5402f4b808d.1368191734.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No modification in CFG register configuration, just rearrange
bits directives to group logically and make it more readable.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/dma/at_hdmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 78c3fb4..9e1ad73 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1228,11 +1228,10 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
 	 * ignored depending on DMA transfer direction.
 	 */
 	per_id = dma_spec->args[1];
-	atslave->cfg = ATC_FIFOCFG_HALFFIFO | ATC_DST_H2SEL_HW
-		      | ATC_SRC_H2SEL_HW | ATC_DST_PER(per_id)
-		      | ATC_DST_PER_MSB(per_id)
-		      | ATC_SRC_PER_MSB(per_id)
-		      | ATC_SRC_PER(per_id);
+	atslave->cfg = ATC_FIFOCFG_HALFFIFO
+		     | ATC_DST_H2SEL_HW | ATC_SRC_H2SEL_HW
+		     | ATC_DST_PER_MSB(per_id) | ATC_DST_PER(per_id)
+		     | ATC_SRC_PER_MSB(per_id) | ATC_SRC_PER(per_id);
 	atslave->dma_dev = &dmac_pdev->dev;
 
 	chan = dma_request_channel(mask, at_dma_filter, atslave);
-- 
1.8.0
