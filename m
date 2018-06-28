From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Thu, 28 Jun 2018 18:41:46 +0530
Subject: [PATCH v3 net-next 1/5] net: emaclite: Use __func__ instead of
 hardcoded name
In-Reply-To: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1530191510-10310-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1530191510-10310-2-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch hardcoded function name with a reference to __func__ making
the code more maintainable. Address below checkpatch warning:

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_read',
this function's name, in a string
+               "xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",

WARNING: Prefer using '"%s...", __func__' to using 'xemaclite_mdio_write',
this function's name, in a string
+               "xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
Changes from v2:
	- None
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 2a0c06e..0544134 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -757,7 +757,7 @@ static int xemaclite_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	rc = xemaclite_readl(lp->base_addr + XEL_MDIORD_OFFSET);
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_read(phy_id=%i, reg=%x) == %x\n",
+		"%s(phy_id=%i, reg=%x) == %x\n", __func__,
 		phy_id, reg, rc);
 
 	return rc;
@@ -780,7 +780,7 @@ static int xemaclite_mdio_write(struct mii_bus *bus, int phy_id, int reg,
 	u32 ctrl_reg;
 
 	dev_dbg(&lp->ndev->dev,
-		"xemaclite_mdio_write(phy_id=%i, reg=%x, val=%x)\n",
+		"%s(phy_id=%i, reg=%x, val=%x)\n", __func__,
 		phy_id, reg, val);
 
 	if (xemaclite_mdio_wait(lp))
-- 
1.7.1
