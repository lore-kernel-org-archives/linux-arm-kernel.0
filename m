From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 31 Jan 2015 17:32:54 +0100
Subject: [PATCH 01/11] drm/encoder: allow encoders to remember their of_node
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <1422721984-27782-2-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an of_node field to struct drm_encoder to let encoders optionally
remember from which devicetree node they originated.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 include/drm/drm_crtc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
index cc369f3..0448732 100644
--- a/include/drm/drm_crtc.h
+++ b/include/drm/drm_crtc.h
@@ -527,6 +527,7 @@ struct drm_encoder_funcs {
 /**
  * struct drm_encoder - central DRM encoder structure
  * @dev: parent DRM device
+ * @of_node: device node pointer to the bridge
  * @head: list management
  * @base: base KMS object
  * @name: encoder name
@@ -543,6 +544,9 @@ struct drm_encoder_funcs {
  */
 struct drm_encoder {
 	struct drm_device *dev;
+#ifdef CONFIG_OF
+	struct device_node *of_node;
+#endif
 	struct list_head head;
 
 	struct drm_mode_object base;
-- 
2.1.1
