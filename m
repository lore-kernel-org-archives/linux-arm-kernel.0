From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:28 +0800
Subject: [PATCH 5/7] drm/sun4i: Drop useless assignment in sun4i_layers_init
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The assignment found in the main loop in sun4i_layers_init:

	struct sun4i_layer *layer = layers[i];

is useless as it gets overwritten by the next line:

	layer = sun4i_layer_init_one(drm, plane);

Drop the assignment.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 62552a356d66..92ecc967dcb1 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -167,7 +167,7 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
 	 */
 	for (i = 0; i < ARRAY_SIZE(sun4i_backend_planes); i++) {
 		const struct sun4i_plane_desc *plane = &sun4i_backend_planes[i];
-		struct sun4i_layer *layer = layers[i];
+		struct sun4i_layer *layer;
 
 		layer = sun4i_layer_init_one(drm, plane);
 		if (IS_ERR(layer)) {
-- 
2.11.0
