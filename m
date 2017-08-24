From: roy.pledge@nxp.com (Roy Pledge)
Date: Thu, 24 Aug 2017 16:37:49 -0400
Subject: [v4 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
In-Reply-To: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1503607075-28970-6-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Not relevant and arch dependent. Overkill for PPC.

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 2ce394a..f85c319 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -49,10 +49,6 @@
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
2.7.4
