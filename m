From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:49:04 +0100
Subject: [PATCH 169/222] drm/i915: don't disable disconnected outputs
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdecq-0007Og-38@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Conflicts:
	drivers/gpu/drm/drm_crtc_helper.c
---
 drivers/gpu/drm/drm_crtc_helper.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index c43825e8f5c1..039dbcd1dd98 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -281,16 +281,10 @@ drm_encoder_disable(struct drm_encoder *encoder)
 static void __drm_helper_disable_unused_functions(struct drm_device *dev)
 {
 	struct drm_encoder *encoder;
-	struct drm_connector *connector;
 	struct drm_crtc *crtc;
 
 	drm_warn_on_modeset_not_all_locked(dev);
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		if (!connector->encoder)
-			continue;
-	}
-
 	list_for_each_entry(encoder, &dev->mode_config.encoder_list, head) {
 		if (!drm_helper_encoder_in_use(encoder)) {
 			drm_encoder_disable(encoder);
-- 
1.8.3.1
