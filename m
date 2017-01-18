From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:33 -0500
Subject: [PATCH 03/10] soc/qbman: Drop L1_CACHE_BYTES compile time check
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-4-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Not relevant and arch dependent. Overkill for PPC.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 2eaf318..4f1623b 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -48,10 +48,6 @@
 #define DPAA_PORTAL_CE 0
 #define DPAA_PORTAL_CI 1
 
-#if (L1_CACHE_BYTES != 32) && (L1_CACHE_BYTES != 64)
-#error "Unsupported Cacheline Size"
-#endif
-
 static inline void dpaa_flush(void *p)
 {
 #ifdef CONFIG_PPC
-- 
1.7.9.5
