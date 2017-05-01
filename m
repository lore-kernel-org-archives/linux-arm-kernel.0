From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 1 May 2017 17:30:07 -0400
Subject: [PATCH v3 05/11] soc/fsl/qbman: Drop L1_CACHE_BYTES compile time check
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1493674213-963-6-git-send-email-roy.pledge@nxp.com>
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
