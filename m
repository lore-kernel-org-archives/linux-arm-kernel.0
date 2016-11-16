From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Wed, 16 Nov 2016 22:50:16 +0000
Subject: [PATCH] net: bcm63xx_enet: fix build failure
Message-ID: <1479336616-26500-1-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The build of mips bcm63xx_defconfig was failing with the error:
drivers/net/ethernet/broadcom/bcm63xx_enet.c:1440:2:
	error: expected expression before 'return'

The return statement should be termibated with ';' and not ','.

Fixes: 42469bf5d9bb ("net: bcm63xx_enet: Utilize phy_ethtool_nway_reset")
Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---

build log is at:
https://travis-ci.org/sudipm-mukherjee/parport/jobs/176269457

 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index a43ab90..3b14d51 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1435,7 +1435,7 @@ static int bcm_enet_nway_reset(struct net_device *dev)
 
 	priv = netdev_priv(dev);
 	if (priv->has_phy)
-		return phy_ethtool_nway_reset(dev),
+		return phy_ethtool_nway_reset(dev);
 
 	return -EOPNOTSUPP;
 }
-- 
1.9.1
