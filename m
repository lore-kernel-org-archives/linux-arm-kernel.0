From: george.cherian@ti.com (George Cherian)
Date: Fri, 2 May 2014 12:02:01 +0530
Subject: [PATCH v2 3/6] drivers: net: cpsw: Enable CPTS for DRA7xx and AM4372
In-Reply-To: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
References: <1399012324-20737-1-git-send-email-george.cherian@ti.com>
Message-ID: <1399012324-20737-4-git-send-email-george.cherian@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable cpts hardware time stamping for Dra7xx and AM4372.
This enables PTPv2 for DRA7xx and AM4372.

Signed-off-by: George Cherian <george.cherian@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 36aa109..085ffb5 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1398,7 +1398,8 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	struct hwtstamp_config cfg;
 
 	if (priv->version != CPSW_VERSION_1 &&
-	    priv->version != CPSW_VERSION_2)
+	    priv->version != CPSW_VERSION_2 &&
+	    priv->version != CPSW_VERSION_3)
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
@@ -1443,6 +1444,7 @@ static int cpsw_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 		cpsw_hwtstamp_v1(priv);
 		break;
 	case CPSW_VERSION_2:
+	case CPSW_VERSION_3:
 		cpsw_hwtstamp_v2(priv);
 		break;
 	default:
@@ -1459,7 +1461,8 @@ static int cpsw_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
 	struct hwtstamp_config cfg;
 
 	if (priv->version != CPSW_VERSION_1 &&
-	    priv->version != CPSW_VERSION_2)
+	    priv->version != CPSW_VERSION_2 &&
+	    priv->version != CPSW_VERSION_3)
 		return -EOPNOTSUPP;
 
 	cfg.flags = 0;
-- 
1.8.3.1
