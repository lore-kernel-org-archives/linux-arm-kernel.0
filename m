From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Fri, 20 Jul 2018 22:15:08 +0100
Subject: [PATCH 09/10] drm/vc4: Use __drm_atomic_helper_plane_reset instead of
 copying the logic
In-Reply-To: <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180720211509.23605-10-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/vc4/vc4_plane.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_plane.c b/drivers/gpu/drm/vc4/vc4_plane.c
index 9d7a36f148cf..688ad9bb0f08 100644
--- a/drivers/gpu/drm/vc4/vc4_plane.c
+++ b/drivers/gpu/drm/vc4/vc4_plane.c
@@ -200,9 +200,7 @@ static void vc4_plane_reset(struct drm_plane *plane)
 	if (!vc4_state)
 		return;
 
-	plane->state = &vc4_state->base;
-	plane->state->alpha = DRM_BLEND_ALPHA_OPAQUE;
-	vc4_state->base.plane = plane;
+	__drm_atomic_helper_plane_reset(plane, &vc4_state->base);
 }
 
 static void vc4_dlist_write(struct vc4_plane_state *vc4_state, u32 val)
-- 
2.18.0
