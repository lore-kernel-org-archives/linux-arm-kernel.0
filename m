From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 Jan 2018 21:15:03 +0100
Subject: [PATCH] ethernet/mediatek: Delete an error message for a failed
 memory allocation in mtk_add_mac()
Message-ID: <c536cac3-0902-5555-8c4f-0038f3609dc8@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2018 21:06:50 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 54adfd967858..52d489c1ceae 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2427,7 +2427,6 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 				     sizeof(*mac->hw_stats),
 				     GFP_KERNEL);
 	if (!mac->hw_stats) {
-		dev_err(eth->dev, "failed to allocate counter memory\n");
 		err = -ENOMEM;
 		goto free_netdev;
 	}
-- 
2.15.1
