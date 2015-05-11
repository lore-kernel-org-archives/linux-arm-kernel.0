From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 11 May 2015 16:05:02 +0200
Subject: [PATCH v2] net: ll_temac: Use one return statement instead of two
Message-ID: <3a0fa74dd703db5dac4816ef15b6a512ef0f2ec0.1431353091.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use one return statement instead of two to simplify the code.
Both are returning the same value.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2:
- Use the same SoB as sender address - Reported-by: Julia Lawall

 drivers/net/ethernet/xilinx/ll_temac_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 062483f334a5..cfb6bdb37fdc 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -688,10 +688,8 @@ static int temac_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	cur_p = &lp->tx_bd_v[lp->tx_bd_tail];
 
 	if (temac_check_tx_bd_space(lp, num_frag)) {
-		if (!netif_queue_stopped(ndev)) {
+		if (!netif_queue_stopped(ndev))
 			netif_stop_queue(ndev);
-			return NETDEV_TX_BUSY;
-		}
 		return NETDEV_TX_BUSY;
 	}
 
-- 
2.3.5
