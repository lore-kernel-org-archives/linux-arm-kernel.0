From: satendra.t@samsung.com (Satendra Singh Thakur)
Date: Thu,  3 May 2018 14:09:38 +0530
Subject: [PATCH 03/13] drm/kms/mode/exynos-dsi: using helper func
 drm_display_mode_to_videomode for calculating timing parameters
In-Reply-To: <cover.1525087679.git.satendra.t@samsung.com>
References: <cover.1525087679.git.satendra.t@samsung.com>
 <CGME20180503083956epcas5p1eb97f7bd534e58e7154f5f11733e7aa0@epcas5p1.samsung.com>
Message-ID: <e21d94cdd60e8c83140c5a917c255baf88f0e90a.1525087679.git.satendra.t@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid duplicate logic for the same

Signed-off-by: Satendra Singh Thakur <satendra.t@samsung.com>
Cc: Madhur Verma <madhur.verma@samsung.com>
Cc: Hemanshu Srivastava <hemanshu.s@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index 7904ffa..9397e5c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1493,14 +1493,7 @@ static void exynos_dsi_mode_set(struct drm_encoder *encoder,
 	struct videomode *vm = &dsi->vm;
 	struct drm_display_mode *m = adjusted_mode;
 
-	vm->hactive = m->hdisplay;
-	vm->vactive = m->vdisplay;
-	vm->vfront_porch = m->vsync_start - m->vdisplay;
-	vm->vback_porch = m->vtotal - m->vsync_end;
-	vm->vsync_len = m->vsync_end - m->vsync_start;
-	vm->hfront_porch = m->hsync_start - m->hdisplay;
-	vm->hback_porch = m->htotal - m->hsync_end;
-	vm->hsync_len = m->hsync_end - m->hsync_start;
+	drm_display_mode_to_videomode(m, vm);
 }
 
 static const struct drm_encoder_helper_funcs exynos_dsi_encoder_helper_funcs = {
-- 
2.7.4
