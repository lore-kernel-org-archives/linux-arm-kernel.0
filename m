From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Fri, 30 Sep 2016 15:48:50 +0800
Subject: [PATCH] net: ethernet: mediatek: mark symbols static where possible
Message-ID: <1475221730-18773-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We get 2 warnings when building kernel with W=1:
drivers/net/ethernet/mediatek/mtk_eth_soc.c:2041:5: warning: no previous prototype for 'mtk_get_link_ksettings' [-Wmissing-prototypes]
drivers/net/ethernet/mediatek/mtk_eth_soc.c:2052:5: warning: no previous prototype for 'mtk_set_link_ksettings' [-Wmissing-prototypes]

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
So this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index ddf20a0..ad4ab97 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -2038,8 +2038,8 @@ static int mtk_cleanup(struct mtk_eth *eth)
 	return 0;
 }
 
-int mtk_get_link_ksettings(struct net_device *ndev,
-			   struct ethtool_link_ksettings *cmd)
+static int mtk_get_link_ksettings(struct net_device *ndev,
+				  struct ethtool_link_ksettings *cmd)
 {
 	struct mtk_mac *mac = netdev_priv(ndev);
 
@@ -2049,8 +2049,8 @@ int mtk_get_link_ksettings(struct net_device *ndev,
 	return phy_ethtool_ksettings_get(ndev->phydev, cmd);
 }
 
-int mtk_set_link_ksettings(struct net_device *ndev,
-			   const struct ethtool_link_ksettings *cmd)
+static int mtk_set_link_ksettings(struct net_device *ndev,
+				  const struct ethtool_link_ksettings *cmd)
 {
 	struct mtk_mac *mac = netdev_priv(ndev);
 
-- 
2.7.4
