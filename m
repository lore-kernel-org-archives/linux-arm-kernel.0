From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 15 Nov 2016 10:06:32 -0800
Subject: [PATCH 03/15] net: bcm63xx_enet: Utilize phy_ethtool_nway_reset
In-Reply-To: <20161115180644.3941-1-f.fainelli@gmail.com>
References: <20161115180644.3941-1-f.fainelli@gmail.com>
Message-ID: <20161115180644.3941-4-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 5c7acef1de2e..a43ab90c051e 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1434,11 +1434,8 @@ static int bcm_enet_nway_reset(struct net_device *dev)
 	struct bcm_enet_priv *priv;
 
 	priv = netdev_priv(dev);
-	if (priv->has_phy) {
-		if (!dev->phydev)
-			return -ENODEV;
-		return genphy_restart_aneg(dev->phydev);
-	}
+	if (priv->has_phy)
+		return phy_ethtool_nway_reset(dev),
 
 	return -EOPNOTSUPP;
 }
-- 
2.9.3
