From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  8 Mar 2016 21:49:37 -0800
Subject: [PATCH 2/2] drivers: net: xgene: fix: Remove IRQF_SHARED flag
In-Reply-To: <1457502577-2606-1-git-send-email-isubramanian@apm.com>
References: <1457502577-2606-1-git-send-email-isubramanian@apm.com>
Message-ID: <1457502577-2606-3-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not allowing sharing of IRQs.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Tested-by: Toan Le <toanle@apm.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 0878aec..f68c187 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -630,7 +630,7 @@ static int xgene_enet_register_irq(struct net_device *ndev)
 		ring = pdata->rx_ring[i];
 		irq_set_status_flags(ring->irq, IRQ_DISABLE_UNLAZY);
 		ret = devm_request_irq(dev, ring->irq, xgene_enet_rx_irq,
-				       IRQF_SHARED, ring->irq_name, ring);
+				       0, ring->irq_name, ring);
 		if (ret) {
 			netdev_err(ndev, "Failed to request irq %s\n",
 				   ring->irq_name);
@@ -641,7 +641,7 @@ static int xgene_enet_register_irq(struct net_device *ndev)
 		ring = pdata->tx_ring[i]->cp_ring;
 		irq_set_status_flags(ring->irq, IRQ_DISABLE_UNLAZY);
 		ret = devm_request_irq(dev, ring->irq, xgene_enet_rx_irq,
-				       IRQF_SHARED, ring->irq_name, ring);
+				       0, ring->irq_name, ring);
 		if (ret) {
 			netdev_err(ndev, "Failed to request irq %s\n",
 				   ring->irq_name);
-- 
1.9.1
