From: madalin.bucur@nxp.com (Madalin Bucur)
Date: Wed, 14 Mar 2018 08:37:30 -0500
Subject: [PATCH 3/5] dpaa_eth: remove duplicate initialization
In-Reply-To: <20180314133732.24068-1-madalin.bucur@nxp.com>
References: <20180314133732.24068-1-madalin.bucur@nxp.com>
Message-ID: <20180314133732.24068-4-madalin.bucur@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Camelia Groza <camelia.groza@nxp.com>

The fd_format has already been initialized at this point.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 128e0a4..3e83d79 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2289,7 +2289,6 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	vaddr = phys_to_virt(addr);
 	prefetch(vaddr + qm_fd_get_offset(fd));
 
-	fd_format = qm_fd_get_format(fd);
 	/* The only FD types that we may receive are contig and S/G */
 	WARN_ON((fd_format != qm_fd_contig) && (fd_format != qm_fd_sg));
 
-- 
2.1.0
