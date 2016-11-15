From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 15 Nov 2016 10:06:36 -0800
Subject: [PATCH 07/15] net: ethernet: ll_temac: Utilize phy_ethtool_nway_reset
In-Reply-To: <20161115180644.3941-1-f.fainelli@gmail.com>
References: <20161115180644.3941-1-f.fainelli@gmail.com>
Message-ID: <20161115180644.3941-8-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index a9bd665fd122..bcd7b76dde9f 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -967,13 +967,8 @@ static const struct attribute_group temac_attr_group = {
 };
 
 /* ethtool support */
-static int temac_nway_reset(struct net_device *ndev)
-{
-	return phy_start_aneg(ndev->phydev);
-}
-
 static const struct ethtool_ops temac_ethtool_ops = {
-	.nway_reset = temac_nway_reset,
+	.nway_reset = phy_ethtool_nway_reset,
 	.get_link = ethtool_op_get_link,
 	.get_ts_info = ethtool_op_get_ts_info,
 	.get_link_ksettings = phy_ethtool_get_link_ksettings,
-- 
2.9.3
