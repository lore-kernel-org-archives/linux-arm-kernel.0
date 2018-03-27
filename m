From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Mar 2018 12:31:46 -0400
Subject: [net-next PATCH v2 07/10] net: netcp: ethss: re-use stats handling
 code for 2u hardware
In-Reply-To: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1522168309-12338-8-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The stats block in 2u cpsw hardware is similar to the one on nu
and hence handle it in a similar way by using a macro that includes
2u hardware as well.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_ethss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/netcp_ethss.c b/drivers/net/ethernet/ti/netcp_ethss.c
index 828243d..26ccddb 100644
--- a/drivers/net/ethernet/ti/netcp_ethss.c
+++ b/drivers/net/ethernet/ti/netcp_ethss.c
@@ -3394,7 +3394,7 @@ static int set_gbenu_ethss_priv(struct gbe_priv *gbe_dev,
 	gbe_dev->num_stats_mods = gbe_dev->max_num_ports;
 	gbe_dev->et_stats = gbenu_et_stats;
 
-	if (IS_SS_ID_NU(gbe_dev))
+	if (IS_SS_ID_MU(gbe_dev))
 		gbe_dev->num_et_stats = GBENU_ET_STATS_HOST_SIZE +
 			(gbe_dev->max_num_slaves * GBENU_ET_STATS_PORT_SIZE);
 	else
-- 
1.9.1
