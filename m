From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Thu, 29 Jun 2017 11:25:46 -0500
Subject: [PATCH] staging: fsl-dpaa2/eth: Remove dead code
Message-ID: <20170629162546.10372-1-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All possible values of the switch statement are explicitly
handled, so there's no need to have a default branch.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index 5312edc26f01..031179ab3a22 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -217,8 +217,6 @@ static void dpaa2_eth_get_ethtool_stats(struct net_device *net_dev,
 		case 2:
 			num_cnt = sizeof(dpni_stats.page_2) / sizeof(u64);
 			break;
-		default:
-			break;
 		}
 		for (k = 0; k < num_cnt; k++)
 			*(data + i++) = dpni_stats.raw.counter[k];
-- 
2.11.0
