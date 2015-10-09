From: eric@anholt.net (Eric Anholt)
Date: Fri,  9 Oct 2015 14:27:46 -0700
Subject: [PATCH v3 5/7] drm/vc4: Allow vblank to be disabled
In-Reply-To: <1444426068-15817-1-git-send-email-eric@anholt.net>
References: <1444426068-15817-1-git-send-email-eric@anholt.net>
Message-ID: <1444426068-15817-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Derek Foreman <derekf@osg.samsung.com>

Signed-off-by: Derek Foreman <derekf@osg.samsung.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index ee3e004..2e5597d 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -51,6 +51,7 @@ int vc4_kms_load(struct drm_device *dev)
 	dev->mode_config.max_height = 2048;
 	dev->mode_config.funcs = &vc4_mode_funcs;
 	dev->mode_config.preferred_depth = 24;
+	dev->vblank_disable_allowed = true;
 
 	drm_mode_config_reset(dev);
 
-- 
2.1.4
