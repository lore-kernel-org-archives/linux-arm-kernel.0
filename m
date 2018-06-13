From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Wed, 13 Jun 2018 12:05:19 +0530
Subject: [PATCH 4/4] net: emaclite: Remove xemaclite_mdio_setup return check
In-Reply-To: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1528871719-1681-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1528871719-1681-5-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Errors are already reported in xemaclite_mdio_setup so avoid
reporting it again.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index ec4608e..2a0c06e 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1143,9 +1143,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	xemaclite_update_address(lp, ndev->dev_addr);
 
 	lp->phy_node = of_parse_phandle(ofdev->dev.of_node, "phy-handle", 0);
-	rc = xemaclite_mdio_setup(lp, &ofdev->dev);
-	if (rc)
-		dev_warn(&ofdev->dev, "error registering MDIO bus\n");
+	xemaclite_mdio_setup(lp, &ofdev->dev);
 
 	dev_info(dev, "MAC address is now %pM\n", ndev->dev_addr);
 
-- 
1.7.1
