From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Mon,  5 Feb 2018 21:09:59 +0100
Subject: [PATCH 2/4] drm/exynos: fix comparison to bitshift when dealing with
 a mask
In-Reply-To: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
Message-ID: <20180205201002.23621-3-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
Only build tested. To be applied individually per subsystem.

 drivers/gpu/drm/exynos/regs-fimc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/regs-fimc.h b/drivers/gpu/drm/exynos/regs-fimc.h
index 30496134a3d072..d7cbe53c4c01f4 100644
--- a/drivers/gpu/drm/exynos/regs-fimc.h
+++ b/drivers/gpu/drm/exynos/regs-fimc.h
@@ -569,7 +569,7 @@
 #define EXYNOS_CIIMGEFF_FIN_EMBOSSING		(4 << 26)
 #define EXYNOS_CIIMGEFF_FIN_SILHOUETTE		(5 << 26)
 #define EXYNOS_CIIMGEFF_FIN_MASK			(7 << 26)
-#define EXYNOS_CIIMGEFF_PAT_CBCR_MASK		((0xff < 13) | (0xff < 0))
+#define EXYNOS_CIIMGEFF_PAT_CBCR_MASK		((0xff << 13) | (0xff << 0))
 
 /* Real input DMA size register */
 #define EXYNOS_CIREAL_ISIZE_AUTOLOAD_ENABLE	(1 << 31)
-- 
2.11.0
