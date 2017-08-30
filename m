From: bhumirks@gmail.com (Bhumika Goyal)
Date: Wed, 30 Aug 2017 14:55:08 +0530
Subject: [PATCH] net: bcm63xx_enet: make bcm_enetsw_ethtool_ops const
Message-ID: <1504085108-23495-1-git-send-email-bhumirks@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make this const as it is never modified.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index 61a88b6..4f3845a 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -2674,7 +2674,7 @@ static int bcm_enetsw_set_ringparam(struct net_device *dev,
 	return 0;
 }
 
-static struct ethtool_ops bcm_enetsw_ethtool_ops = {
+static const struct ethtool_ops bcm_enetsw_ethtool_ops = {
 	.get_strings		= bcm_enetsw_get_strings,
 	.get_sset_count		= bcm_enetsw_get_sset_count,
 	.get_ethtool_stats      = bcm_enetsw_get_ethtool_stats,
-- 
1.9.1
