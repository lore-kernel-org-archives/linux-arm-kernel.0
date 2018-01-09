From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  9 Jan 2018 11:56:31 +0100
Subject: [PATCH 12/19] drm/sun4i: backend: Move the coord function in the
 shared part
In-Reply-To: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
References: <cover.713e47b83733ed05f0c38f5ba6ef8b6c1e32805c.1515494838.git-series.maxime.ripard@free-electrons.com>
Message-ID: <d355fd0475336a41e9611c6a92fabb0839c73dc8.1515494838.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function supposed to update a plane's coordinates is called in both
branches of our function. Let's move it out the if statement.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index f03da16eb92a..c448cb6b9fa9 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -106,14 +106,13 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 					      DRM_FORMAT_ARGB8888);
 		sun4i_backend_update_layer_frontend(backend, layer->id,
 						    DRM_FORMAT_ARGB8888);
-		sun4i_backend_update_layer_coord(backend, layer->id, plane);
 		sun4i_frontend_enable(frontend);
 	} else {
-		sun4i_backend_update_layer_coord(backend, layer->id, plane);
 		sun4i_backend_update_layer_formats(backend, layer->id, plane);
 		sun4i_backend_update_layer_buffer(backend, layer->id, plane);
 	}
 
+	sun4i_backend_update_layer_coord(backend, layer->id, plane);
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
-- 
git-series 0.9.1
