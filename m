From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Fri, 20 Jul 2018 22:15:07 +0100
Subject: [PATCH 08/10] drm/sun4i: Use __drm_atomic_helper_plane_reset instead
 of copying the logic
In-Reply-To: <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180720211509.23605-9-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index 750ad24de1d7..78f77af8805a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -35,9 +35,7 @@ static void sun4i_backend_layer_reset(struct drm_plane *plane)
 
 	state = kzalloc(sizeof(*state), GFP_KERNEL);
 	if (state) {
-		plane->state = &state->state;
-		plane->state->plane = plane;
-		plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
+		__drm_atomic_helper_plane_reset(plane, &state->state);
 		plane->state->zpos = layer->id;
 	}
 }
-- 
2.18.0
