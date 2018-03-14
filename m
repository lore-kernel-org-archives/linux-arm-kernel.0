From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 14 Mar 2018 08:37:32 -0500
Subject: [PATCH 5/5] dpaa_eth: remove duplicate increment of the tx_errors
 counter
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Message-ID: <20180314133732.24068-6-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Camelia Groza <camelia.groza@nxp.com>

The tx_errors counter is incremented by the dpaa_xmit caller.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 76b3c9e..fd43f98 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2021,7 +2021,6 @@ static inline int dpaa_xmit(struct dpaa_priv *priv,
 	}
 
 	if (unlikely(err < 0)) {
-		percpu_stats->tx_errors++;
 		percpu_stats->tx_fifo_errors++;
 		return err;
 	}
-- 
2.1.0
