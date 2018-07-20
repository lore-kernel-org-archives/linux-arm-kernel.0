From: alexandru-cosmin.gheorghe@arm.com (Alexandru Gheorghe)
Date: Fri, 20 Jul 2018 22:15:04 +0100
Subject: [PATCH 05/10] drm/exynos: Use __drm_atomic_helper_plane_reset instead
 of copying the logic
In-Reply-To: <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
References: <20180713161407.GQ20303@art_vandelay>
 <20180720211509.23605-1-alexandru-cosmin.gheorghe@arm.com>
Message-ID: <20180720211509.23605-6-alexandru-cosmin.gheorghe@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandru Gheorghe <alexandru-cosmin.gheorghe@arm.com>
---
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_plane.c b/drivers/gpu/drm/exynos/exynos_drm_plane.c
index eb9915da7dec..681328fbe7de 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_plane.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_plane.c
@@ -139,8 +139,7 @@ static void exynos_drm_plane_reset(struct drm_plane *plane)
 
 	exynos_state = kzalloc(sizeof(*exynos_state), GFP_KERNEL);
 	if (exynos_state) {
-		plane->state = &exynos_state->base;
-		plane->state->plane = plane;
+		__drm_atomic_helper_plane_reset(plane, &exynos_state->base);
 		plane->state->zpos = exynos_plane->config->zpos;
 	}
 }
-- 
2.18.0
