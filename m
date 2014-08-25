From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 25 Aug 2014 16:30:22 +0900
Subject: [PATCHv4 1/4] thermal: exynos: Fix wrong value of
 TRIMINFO_RELOAD_SHIFT
In-Reply-To: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
References: <1408951825-2639-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1408951825-2639-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix wrong value of TRIMINFO_RELOAD_SHIFT. TRIMINFO_CONTROL register
has 'RELOAD' field at [0] bit.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <cw00.choi@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/samsung/exynos_tmu_data.h b/drivers/thermal/samsung/exynos_tmu_data.h
index f0979e5..401bab7 100644
--- a/drivers/thermal/samsung/exynos_tmu_data.h
+++ b/drivers/thermal/samsung/exynos_tmu_data.h
@@ -63,7 +63,7 @@
 #define EXYNOS_THD_TEMP_FALL		0x54
 #define EXYNOS_EMUL_CON		0x80
 
-#define EXYNOS_TRIMINFO_RELOAD_SHIFT	1
+#define EXYNOS_TRIMINFO_RELOAD_SHIFT	0
 #define EXYNOS_TRIMINFO_25_SHIFT	0
 #define EXYNOS_TRIMINFO_85_SHIFT	8
 #define EXYNOS_TMU_RISE_INT_MASK	0x111
-- 
1.8.0
