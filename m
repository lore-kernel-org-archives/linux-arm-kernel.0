From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon,  3 Jul 2017 21:35:20 +0530
Subject: [PATCH] drm/sun4i : constify drm_plane_helper_funcs
Message-ID: <bcf0c7481aa8bc4731ea3fc7e71815fbb7703681.1499097717.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_plane_helper_funcs are not supposed to change at runtime.
All functions working with drm_plane_helper_funcs provided by
<drm/drm_plane_helper.h> work with const drm_plane_helper_funcs.
So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    981	     40	      0	   1021	    3fd drivers/gpu/drm/sun4i/sun4i_layer.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   1021	      0	      0	   1021	    3fd drivers/gpu/drm/sun4i/sun4i_layer.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_layer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index f26bde5..6191aac 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -52,7 +52,7 @@ static void sun4i_backend_layer_atomic_update(struct drm_plane *plane,
 	sun4i_backend_layer_enable(backend, layer->id, true);
 }
 
-static struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
+static const struct drm_plane_helper_funcs sun4i_backend_layer_helper_funcs = {
 	.atomic_check	= sun4i_backend_layer_atomic_check,
 	.atomic_disable	= sun4i_backend_layer_atomic_disable,
 	.atomic_update	= sun4i_backend_layer_atomic_update,
-- 
2.7.4
