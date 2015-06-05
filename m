From: michal.simek@xilinx.com (Michal Simek)
Date: Fri,  5 Jun 2015 10:49:17 +0200
Subject: [PATCH] net: ll_temac: Remove sparse warnings
Message-ID: <343ee9fccc37629414209d4c05077eb52aed8ed2.1433494150.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove sparse warnings:
drivers/net/ethernet/xilinx/ll_temac_main.c:65:16: warning: cast removes
address space of expression
drivers/net/ethernet/xilinx/ll_temac_main.c:70:9: warning: cast removes
address space of expression
drivers/net/ethernet/xilinx/ll_temac_main.c:127:16: warning: cast
removes address space of expression
drivers/net/ethernet/xilinx/ll_temac_main.c:137:9: warning: cast removes
address space of expression
drivers/net/ethernet/xilinx/ll_temac_main.c:409:3: warning: symbol
'temac_options' was not declared. Should it be static?
drivers/net/ethernet/xilinx/ll_temac_main.c:590:6: warning: symbol
'temac_adjust_link' was not declared. Should it be static?

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/net/ethernet/xilinx/ll_temac_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index 3b99a4df71f8..5a1068df7038 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -62,12 +62,12 @@
 
 u32 temac_ior(struct temac_local *lp, int offset)
 {
-	return in_be32((u32 *)(lp->regs + offset));
+	return in_be32(lp->regs + offset);
 }
 
 void temac_iow(struct temac_local *lp, int offset, u32 value)
 {
-	out_be32((u32 *) (lp->regs + offset), value);
+	out_be32(lp->regs + offset, value);
 }
 
 int temac_indirect_busywait(struct temac_local *lp)
@@ -124,7 +124,7 @@ void temac_indirect_out32(struct temac_local *lp, int reg, u32 value)
  */
 static u32 temac_dma_in32(struct temac_local *lp, int reg)
 {
-	return in_be32((u32 *)(lp->sdma_regs + (reg << 2)));
+	return in_be32(lp->sdma_regs + (reg << 2));
 }
 
 /**
@@ -134,7 +134,7 @@ static u32 temac_dma_in32(struct temac_local *lp, int reg)
  */
 static void temac_dma_out32(struct temac_local *lp, int reg, u32 value)
 {
-	out_be32((u32 *)(lp->sdma_regs + (reg << 2)), value);
+	out_be32(lp->sdma_regs + (reg << 2), value);
 }
 
 /* DMA register access functions can be DCR based or memory mapped.
@@ -400,7 +400,7 @@ static void temac_set_multicast_list(struct net_device *ndev)
 	mutex_unlock(&lp->indirect_mutex);
 }
 
-struct temac_option {
+static struct temac_option {
 	int flg;
 	u32 opt;
 	u32 reg;
@@ -587,7 +587,7 @@ static void temac_device_reset(struct net_device *ndev)
 	ndev->trans_start = jiffies; /* prevent tx timeout */
 }
 
-void temac_adjust_link(struct net_device *ndev)
+static void temac_adjust_link(struct net_device *ndev)
 {
 	struct temac_local *lp = netdev_priv(ndev);
 	struct phy_device *phy = lp->phy_dev;
-- 
2.3.5
