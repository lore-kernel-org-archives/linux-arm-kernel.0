From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Fri, 23 Nov 2018 10:24:47 +0100
Subject: [PATCH v2 15/43] drm/sun4i: Rename sun4i_backend_layer_formats to
 sun4i_layer_formats
In-Reply-To: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
References: <20181123092515.2511-1-paul.kocialkowski@bootlin.com>
Message-ID: <20181123092515.2511-16-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since more formats can be supported by the frontend, rename the
variable listing the layer formats to avoid suggesting that the backend
itself supports all the listed formats.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 50bb16566f03..c3368b17e5f1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -127,7 +127,7 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 	.update_plane		= drm_atomic_helper_update_plane,
 };
 
-static const uint32_t sun4i_backend_layer_formats[] = {
+static const uint32_t sun4i_layer_formats[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_ARGB4444,
 	DRM_FORMAT_ARGB1555,
@@ -156,8 +156,8 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 	/* possible crtcs are set later */
 	ret = drm_universal_plane_init(drm, &layer->plane, 0,
 				       &sun4i_backend_layer_funcs,
-				       sun4i_backend_layer_formats,
-				       ARRAY_SIZE(sun4i_backend_layer_formats),
+				       sun4i_layer_formats,
+				       ARRAY_SIZE(sun4i_layer_formats),
 				       NULL, type, NULL);
 	if (ret) {
 		dev_err(drm->dev, "Couldn't initialize layer\n");
-- 
2.19.1
