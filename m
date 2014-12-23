From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Tue, 23 Dec 2014 18:07:55 +0530
Subject: [PATCH] net: xilinx: Remove unnecessary temac_property in the driver
Message-ID: <072fa5b149374b09b3f6d5d767714d3e@BN1AFFO11FD010.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is no longer used in the code yet the code looks for it in the device tree.
It does not cause an error if it's not in the tree.

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h      |    2 --
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c |    4 ----
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 44b8d2b..4c9b4fa 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -388,7 +388,6 @@ struct axidma_bd {
  * @dma_err_tasklet: Tasklet structure to process Axi DMA errors
  * @tx_irq:	Axidma TX IRQ number
  * @rx_irq:	Axidma RX IRQ number
- * @temac_type:	axienet type to identify between soft and hard temac
  * @phy_type:	Phy type to identify between MII/GMII/RGMII/SGMII/1000 Base-X
  * @options:	AxiEthernet option word
  * @last_link:	Phy link state in which the PHY was negotiated earlier
@@ -431,7 +430,6 @@ struct axienet_local {
 
 	int tx_irq;
 	int rx_irq;
-	u32 temac_type;
 	u32 phy_type;
 
 	u32 options;			/* Current options word */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 4ea2d4e..c18a0c6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1555,10 +1555,6 @@ static int axienet_of_probe(struct platform_device *op)
 		if ((be32_to_cpup(p)) >= 0x4000)
 			lp->jumbo_support = 1;
 	}
-	p = (__be32 *) of_get_property(op->dev.of_node, "xlnx,temac-type",
-				       NULL);
-	if (p)
-		lp->temac_type = be32_to_cpup(p);
 	p = (__be32 *) of_get_property(op->dev.of_node, "xlnx,phy-type", NULL);
 	if (p)
 		lp->phy_type = be32_to_cpup(p);
-- 
1.7.4
