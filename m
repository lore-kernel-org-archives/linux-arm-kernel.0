From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sun,  4 May 2014 23:26:19 +0800
Subject: [PATCH 2/4] drm/exynos/mixer: use MXR_GRP_SXY_SY
In-Reply-To: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
References: <1399217181-26442-1-git-send-email-djkurtz@chromium.org>
Message-ID: <1399217181-26442-3-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mixer hardware supports offsetting dma from start of source buffer using
the MXR_GRP_SXY register.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_mixer.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 475eb49..40cf39b 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -529,13 +529,11 @@ static void mixer_graph_buffer(struct mixer_context *ctx, int win)
 
 	dst_x_offset = win_data->crtc_x;
 	dst_y_offset = win_data->crtc_y;
+	src_x_offset = win_data->fb_x;
+	src_y_offset = win_data->fb_y;
 
 	/* converting dma address base and source offset */
-	dma_addr = win_data->dma_addr
-		+ (win_data->fb_x * win_data->bpp >> 3)
-		+ (win_data->fb_y * win_data->fb_width * win_data->bpp >> 3);
-	src_x_offset = 0;
-	src_y_offset = 0;
+	dma_addr = win_data->dma_addr;
 
 	if (win_data->scan_flags & DRM_MODE_FLAG_INTERLACE)
 		ctx->interlace = true;
-- 
1.9.1.423.g4596e3a
