From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Oct 2016 10:46:14 +0200
Subject: [PATCH] drm/sun4i: Add a few formats
Message-ID: <20161018084614.2443-1-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The planes can do more than what was previously exposed. Add support for
them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/gpu/drm/sun4i/sun4i_backend.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/sun4i/sun4i_layer.c   |  6 ++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index afb7ddf660ef..b184a476a480 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -96,6 +96,22 @@ static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
 		*mode = SUN4I_BACKEND_LAY_FBFMT_ARGB8888;
 		break;
 
+	case DRM_FORMAT_ARGB4444:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_ARGB4444;
+		break;
+
+	case DRM_FORMAT_ARGB1555:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_ARGB1555;
+		break;
+
+	case DRM_FORMAT_RGBA5551:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_RGBA5551;
+		break;
+
+	case DRM_FORMAT_RGBA4444:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_RGBA4444;
+		break;
+
 	case DRM_FORMAT_XRGB8888:
 		*mode = SUN4I_BACKEND_LAY_FBFMT_XRGB8888;
 		break;
@@ -104,6 +120,10 @@ static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
 		*mode = SUN4I_BACKEND_LAY_FBFMT_RGB888;
 		break;
 
+	case DRM_FORMAT_RGB565:
+		*mode = SUN4I_BACKEND_LAY_FBFMT_RGB565;
+		break;
+
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
index f0035bf5efea..5d53c977bca5 100644
--- a/drivers/gpu/drm/sun4i/sun4i_layer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
@@ -73,12 +73,18 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
 static const uint32_t sun4i_backend_layer_formats_primary[] = {
 	DRM_FORMAT_ARGB8888,
 	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 };
 
 static const uint32_t sun4i_backend_layer_formats_overlay[] = {
 	DRM_FORMAT_ARGB8888,
+	DRM_FORMAT_ARGB4444,
+	DRM_FORMAT_ARGB1555,
+	DRM_FORMAT_RGBA5551,
+	DRM_FORMAT_RGBA4444,
 	DRM_FORMAT_RGB888,
+	DRM_FORMAT_RGB565,
 	DRM_FORMAT_XRGB8888,
 };
 
-- 
2.9.3
