From: roy.pledge@nxp.com (Roy Pledge)
Date: Wed, 18 Jan 2017 17:39:34 -0500
Subject: [PATCH 04/10] soc/qbman: Fix ARM32 typo
In-Reply-To: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
References: <1484779180-1344-1-git-send-email-roy.pledge@nxp.com>
Message-ID: <1484779180-1344-5-git-send-email-roy.pledge@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentin Rothberg <valentinrothberg@gmail.com>

The Kconfig symbol for 32bit ARM is 'ARM', not 'ARM32'.

Signed-off-by: Valentin Rothberg <valentinrothberg@gmail.com>
Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
 drivers/soc/fsl/qbman/dpaa_sys.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
index 4f1623b..ae65758 100644
--- a/drivers/soc/fsl/qbman/dpaa_sys.h
+++ b/drivers/soc/fsl/qbman/dpaa_sys.h
@@ -52,7 +52,7 @@ static inline void dpaa_flush(void *p)
 {
 #ifdef CONFIG_PPC
 	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
-#elif defined(CONFIG_ARM32)
+#elif defined(CONFIG_ARM)
 	__cpuc_flush_dcache_area(p, 64);
 #elif defined(CONFIG_ARM64)
 	__flush_dcache_area(p, 64);
-- 
1.7.9.5
