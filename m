From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 17 Feb 2017 11:13:29 +0800
Subject: [PATCH 6/7] drm/sun4i: Save newly created layer in layers array in
 sun4i_layers_init
In-Reply-To: <20170217031330.14087-1-wens@csie.org>
References: <20170217031330.14087-1-wens@csie.org>
Message-ID: <20170217031330.14087-7-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sun4i_layers_init allocates an array to store pointers to newly created
layers returned by sun4i_layer_init_one(), but fails to actually store
them. But it actually returns the empty array to unsuspecting users.

Save the pointers in the array, so that they may be used later.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 92ecc967dcb1..41bc0f860f5c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -183,6 +183,7 @@ struct sun4i_layer **sun4i_layers_init(struct drm_device *drm)
 				   SUN4I_BACKEND_ATTCTL_REG0_LAY_PIPESEL(plane->pipe));
 
 		layer->id = i;
+		layers[i] = layer;
 	};
 
 	return layers;
-- 
2.11.0
