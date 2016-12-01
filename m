From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 21:09:25 +0100
Subject: [PATCH v2 2/7] drm: Turn DRM_MODE_SUBCONNECTOR_xx definitions into an
 enum
In-Reply-To: <1480622970-8714-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480622970-8714-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1480622970-8714-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List of values like the DRM_MODE_SUBCONNECTOR_xx ones are better
represented with enums.

Turn the DRM_MODE_SUBCONNECTOR_xx macros into an enum.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 include/uapi/drm/drm_mode.h | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index df0e3504c349..970bfc0d7107 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -220,14 +220,16 @@ struct drm_mode_get_encoder {
 
 /* This is for connectors with multiple signal types. */
 /* Try to match DRM_MODE_CONNECTOR_X as closely as possible. */
-#define DRM_MODE_SUBCONNECTOR_Automatic	0
-#define DRM_MODE_SUBCONNECTOR_Unknown	0
-#define DRM_MODE_SUBCONNECTOR_DVID	3
-#define DRM_MODE_SUBCONNECTOR_DVIA	4
-#define DRM_MODE_SUBCONNECTOR_Composite	5
-#define DRM_MODE_SUBCONNECTOR_SVIDEO	6
-#define DRM_MODE_SUBCONNECTOR_Component	8
-#define DRM_MODE_SUBCONNECTOR_SCART	9
+enum drm_mode_subconnector {
+	DRM_MODE_SUBCONNECTOR_Automatic = 0,
+	DRM_MODE_SUBCONNECTOR_Unknown = 0,
+	DRM_MODE_SUBCONNECTOR_DVID = 3,
+	DRM_MODE_SUBCONNECTOR_DVIA = 4,
+	DRM_MODE_SUBCONNECTOR_Composite = 5,
+	DRM_MODE_SUBCONNECTOR_SVIDEO = 6,
+	DRM_MODE_SUBCONNECTOR_Component = 8,
+	DRM_MODE_SUBCONNECTOR_SCART = 9,
+};
 
 #define DRM_MODE_CONNECTOR_Unknown	0
 #define DRM_MODE_CONNECTOR_VGA		1
-- 
2.7.4
