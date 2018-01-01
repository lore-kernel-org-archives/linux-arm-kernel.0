From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 Jan 2018 17:40:36 +0100
Subject: [PATCH] bcm63xx_enet: Delete two error messages for a failed memory
 allocation in bcm_enetsw_open()
Message-ID: <e417429f-196b-6d03-0d40-02bfe0cd4903@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 Jan 2018 17:30:04 +0100

Omit extra messages for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index d9346e2ac720..52a42e3058cf 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -2166,7 +2166,6 @@ static int bcm_enetsw_open(struct net_device *dev)
 	priv->tx_skb = kzalloc(sizeof(struct sk_buff *) * priv->tx_ring_size,
 			       GFP_KERNEL);
 	if (!priv->tx_skb) {
-		dev_err(kdev, "cannot allocate rx skb queue\n");
 		ret = -ENOMEM;
 		goto out_free_tx_ring;
 	}
@@ -2180,7 +2179,6 @@ static int bcm_enetsw_open(struct net_device *dev)
 	priv->rx_skb = kzalloc(sizeof(struct sk_buff *) * priv->rx_ring_size,
 			       GFP_KERNEL);
 	if (!priv->rx_skb) {
-		dev_err(kdev, "cannot allocate rx skb queue\n");
 		ret = -ENOMEM;
 		goto out_free_tx_skb;
 	}
-- 
2.15.1
