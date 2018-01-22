From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 22 Jan 2018 11:35:46 +0100
Subject: [PATCH v2 17/19] drm/sun4i: backend: Make zpos configurable
In-Reply-To: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
References: <cover.9e7b6a702e4d90a13d08fbe3b0a319cbf4db687f.1516617243.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d93eb11660b5ad085e7ca189475b45b4d5b5bb3d.1516617243.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have everything in place, we can make zpos configurable now.
Change the zpos property from an immutable one to a regular.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index ec7b906dbb84..9e538f761dcb 100644
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
 
@@ -189,8 +192,6 @@ struct drm_plane **sun4i_layers_init(struct drm_device *drm,
 			return ERR_CAST(layer);
 		};
 
-		drm_plane_create_zpos_immutable_property(&layer->plane, i);
-
 		layer->id = i;
 		planes[i] = &layer->plane;
 	};
-- 
git-series 0.9.1
