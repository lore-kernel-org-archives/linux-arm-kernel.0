From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 18 Jun 2018 17:20:07 +0530
Subject: [PATCH 2/5] net: emaclite: Balance braces in else statement
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove else as it is not required with if doing a return.
Fixes below checkpatch warning.

WARNING: else is not generally useful after a break or return

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 0544134..8d84f58 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -569,13 +569,11 @@ static void xemaclite_tx_handler(struct net_device *dev)
 					(u8 *) lp->deferred_skb->data,
 					lp->deferred_skb->len) != 0)
 			return;
-		else {
-			dev->stats.tx_bytes += lp->deferred_skb->len;
-			dev_kfree_skb_irq(lp->deferred_skb);
-			lp->deferred_skb = NULL;
-			netif_trans_update(dev); /* prevent tx timeout */
-			netif_wake_queue(dev);
-		}
+		dev->stats.tx_bytes += lp->deferred_skb->len;
+		dev_kfree_skb_irq(lp->deferred_skb);
+		lp->deferred_skb = NULL;
+		netif_trans_update(dev); /* prevent tx timeout */
+		netif_wake_queue(dev);
 	}
 }
 
@@ -1052,13 +1050,13 @@ static bool get_bool(struct platform_device *ofdev, const char *s)
 {
 	u32 *p = (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
 
-	if (p) {
+	if (p)
 		return (bool)*p;
-	} else {
-		dev_warn(&ofdev->dev, "Parameter %s not found,"
+
+	dev_warn(&ofdev->dev, "Parameter %s not found,"
 			"defaulting to false\n", s);
-		return false;
-	}
+
+	return false;
 }
 
 static const struct net_device_ops xemaclite_netdev_ops;
-- 
2.7.4
