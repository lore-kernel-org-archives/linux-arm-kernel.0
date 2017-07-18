From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 18 Jul 2017 15:48:06 -0500
Subject: [PATCH] net: ethernet: mediatek: remove useless code in mtk_poll_tx()
Message-ID: <20170718204805.GA30888@embeddedgus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove useless local variable _condition_ and the code related.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index b3d0c2e..7e95cf5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1027,7 +1027,6 @@ static int mtk_poll_tx(struct mtk_eth *eth, int budget)
 	unsigned int done[MTK_MAX_DEVS];
 	unsigned int bytes[MTK_MAX_DEVS];
 	u32 cpu, dma;
-	static int condition;
 	int total = 0, i;
 
 	memset(done, 0, sizeof(done));
@@ -1051,10 +1050,8 @@ static int mtk_poll_tx(struct mtk_eth *eth, int budget)
 			mac = 1;
 
 		skb = tx_buf->skb;
-		if (!skb) {
-			condition = 1;
+		if (!skb)
 			break;
-		}
 
 		if (skb != (struct sk_buff *)MTK_DMA_DUMMY_DESC) {
 			bytes[mac] += skb->len;
-- 
2.5.0
