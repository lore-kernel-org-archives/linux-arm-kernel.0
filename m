From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Aug 2015 17:56:18 -0700
Subject: [PATCH 5/7] drm/vc4: Allow vblank to be disabled
In-Reply-To: <1439427380-2436-1-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
Message-ID: <1439427380-2436-6-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Derek Foreman <derekf@osg.samsung.com>

Signed-off-by: Derek Foreman <derekf@osg.samsung.com>
Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/gpu/drm/vc4/vc4_kms.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index a34439f..f881cd4 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -77,6 +77,8 @@ int vc4_kms_load(struct drm_device *dev)
 	dev->mode_config.funcs = &vc4_mode_funcs;
 	dev->mode_config.preferred_depth = 24;
 
+	dev->vblank_disable_allowed = true;
+
 	ret = vc4_init_modeset_objects(dev);
 	if (ret)
 		goto fail;
-- 
2.1.4
