From: roy.pledge@nxp.com (Roy Pledge)
Date: Mon, 1 May 2017 17:30:12 -0400
Subject: [PATCH v3 10/11] soc/fsl/qbman: Add missing headers on ARM
In-Reply-To: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
References: <1493674213-963-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1493674213-963-11-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Claudiu Manoil <claudiu.manoil@nxp.com>

Unlike PPC builds, ARM builds need following headers
explicitly:
+#include <linux/io.h>		for ioread32be()
+#include <linux/delay.h>		for udelay()

Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 81a9a5e..9925013 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -44,6 +44,8 @@
 #include <linux/prefetch.h>
 #include <linux/genalloc.h>
 #include <asm/cacheflush.h>
+#include <linux/io.h>
+#include <linux/delay.h>
 
 /* For 2-element tables related to cache-inhibited and cache-enabled mappings */
 #define DPAA_PORTAL_CE 0
-- 
2.7.4
