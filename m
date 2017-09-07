From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  7 Sep 2017 14:49:19 +0200
Subject: [PATCH 1/7 v3] drm/pl111: Cleanup local header file
Message-ID: <20170907124925.13805-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The header file contains prototypes for two nonexisting
functions. Get rid of them.

Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v2->v3:
- Rebase on DRM-TIP
ChangeLog v1->v2:
- Collect Eric's ACK.
---
 drivers/gpu/drm/pl111/pl111_drm.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_drm.h b/drivers/gpu/drm/pl111/pl111_drm.h
index 5c685bfc8fdc..a97f303f6833 100644
--- a/drivers/gpu/drm/pl111/pl111_drm.h
+++ b/drivers/gpu/drm/pl111/pl111_drm.h
@@ -58,10 +58,6 @@ int pl111_enable_vblank(struct drm_device *drm, unsigned int crtc);
 void pl111_disable_vblank(struct drm_device *drm, unsigned int crtc);
 irqreturn_t pl111_irq(int irq, void *data);
 int pl111_connector_init(struct drm_device *dev);
-int pl111_encoder_init(struct drm_device *dev);
-int pl111_dumb_create(struct drm_file *file_priv,
-		      struct drm_device *dev,
-		      struct drm_mode_create_dumb *args);
 int pl111_debugfs_init(struct drm_minor *minor);
 
 #endif /* _PL111_DRM_H_ */
-- 
2.13.5
