From: konszert@marvell.com (Kosta Zertsekel)
Date: Thu, 10 Jan 2013 14:00:33 +0200
Subject: [PATCH 1/2] Fix phy_init for Marvell network eth driver
In-Reply-To: <1357819234-27752-1-git-send-email-konszert@marvell.com>
References: <1357819234-27752-1-git-send-email-konszert@marvell.com>
Message-ID: <1357819234-27752-2-git-send-email-konszert@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least it fixes DNS323_REV_C1 board case (mach-orion5x/dsn323-setup.c file).

Change-Id: I37d64795f79c358f66a211a150cec2263e40e295
---
 drivers/net/ethernet/marvell/mv643xx_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index 84c1326..7b8c1ac 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -2789,7 +2789,7 @@ static void phy_init(struct mv643xx_eth_private *mp, int speed, int duplex)
 
 	phy_reset(mp);
 
-	phy_attach(mp->dev, dev_name(&phy->dev), 0, PHY_INTERFACE_MODE_GMII);
+	phy_attach(mp->dev, dev_name(&phy->dev), phy->dev_flags, PHY_INTERFACE_MODE_GMII);
 
 	if (speed == 0) {
 		phy->autoneg = AUTONEG_ENABLE;
-- 
1.8.1
