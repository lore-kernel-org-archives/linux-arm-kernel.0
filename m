From: yt.shen@mediatek.com (YT Shen)
Date: Fri, 30 Sep 2016 14:45:43 +0800
Subject: [PATCH] drm/mediatek: stop using drm_vblank_count() as the hw frame
 counter
Message-ID: <1475217943-12427-1-git-send-email-yt.shen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

using drm_vblank_no_hw_counter() to eliminate kernel warning.

Signed-off-by: YT Shen <yt.shen@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index eebb7d8..e286193 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -239,7 +239,7 @@ static struct drm_driver mtk_drm_driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
 
-	.get_vblank_counter = drm_vblank_count,
+	.get_vblank_counter = drm_vblank_no_hw_counter,
 	.enable_vblank = mtk_drm_crtc_enable_vblank,
 	.disable_vblank = mtk_drm_crtc_disable_vblank,
 
-- 
1.9.1
