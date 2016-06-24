From: chris@chris-wilson.co.uk (Chris Wilson)
Date: Fri, 24 Jun 2016 15:36:19 +0100
Subject: [PATCH 2/5] drm/sun4i: Remove redundant call to
 drm_connector_unregister_all()
In-Reply-To: <1466778982-6974-1-git-send-email-chris@chris-wilson.co.uk>
References: <1466778982-6974-1-git-send-email-chris@chris-wilson.co.uk>
Message-ID: <1466778982-6974-2-git-send-email-chris@chris-wilson.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_connector_unregister_all() is automatically called by
drm_dev_unregister() and so the manual call can be dropped.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: dri-devel at lists.freedesktop.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/gpu/drm/sun4i/sun4i_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
index 5b89940edcb1..b22acc68d3b2 100644
--- a/drivers/gpu/drm/sun4i/sun4i_drv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
@@ -185,7 +185,6 @@ static void sun4i_drv_unbind(struct device *dev)
 {
 	struct drm_device *drm = dev_get_drvdata(dev);
 
-	drm_connector_unregister_all(drm);
 	drm_dev_unregister(drm);
 	drm_kms_helper_poll_fini(drm);
 	sun4i_framebuffer_free(drm);
-- 
2.8.1
