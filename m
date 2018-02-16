From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 16 Feb 2018 18:39:34 +0100
Subject: [PATCH v3 6/8] drm/sun4i: backend: Make zpos configurable
In-Reply-To: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
Message-ID: <0ab187956855db86972d936e6751181649e0d035.1518802627.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have everything in place, we can make zpos configurable now.
Change the zpos property from an immutable one to a regular.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 85cc7e9461b3..33ad377569ec 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -163,6 +163,9 @@ static struct sun4i_layer *sun4i_layer_init_one(struct drm_device *drm,
 			     &sun4i_backend_layer_helper_funcs);
 	layer->backend = backend;
 
+	drm_plane_create_zpos_property(&layer->plane, 0, 0,
+				       SUN4I_BACKEND_NUM_LAYERS - 1);
+
 	return layer;
 }
 
@@ -190,8 +193,6 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 			return ERR_CAST(layer);
 		};
 
-		drm_plane_create_zpos_immutable_property(&layer->plane, i);
-
 		layer->id = i;
 		planes[i] = &layer->plane;
 	};
-- 
git-series 0.9.1
