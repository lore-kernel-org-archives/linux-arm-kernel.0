From: bibby.hsieh@mediatek.com (Bibby Hsieh)
Date: Thu, 4 Aug 2016 10:59:56 +0800
Subject: [PATCH v2 6/7] drm/mediatek: plane: Use FB's format's cpp to compute
 x offset
In-Reply-To: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
References: <1470279597-60453-1-git-send-email-bibby.hsieh@mediatek.com>
Message-ID: <1470279597-60453-7-git-send-email-bibby.hsieh@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Kurtz <djkurtz@chromium.org>

Use the framebuffer's format to compute its cpp, and use it when
calculating the address shift value.

Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_plane.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_plane.c b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
index b3ddb20..c461a23 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_plane.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_plane.c
@@ -135,7 +135,7 @@ static void mtk_plane_atomic_update(struct drm_plane *plane,
 	pitch = fb->pitches[0];
 	format = fb->pixel_format;
 
-	addr += (plane->state->src.x1 >> 16) * 4;
+	addr += (plane->state->src.x1 >> 16) * drm_format_plane_cpp(format, 0);
 	addr += (plane->state->src.y1 >> 16) * pitch;
 
 	state->pending.enable = true;
-- 
1.7.9.5
