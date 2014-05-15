From: stefan@agner.ch (stefan at agner.ch)
Date: Thu, 15 May 2014 11:38:45 +0200
Subject: [PATCH v2] drm/panel: add support for EDT ET057090DHU panel
Message-ID: <1400146725-5788-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stefan Agner <stefan@agner.ch>

This panel is sold by Toradex for Colibri T20/T30 and Apalis T30
evaluation kits.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/panel/edt,et057090dhu.txt  |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/edt,et057090dhu.txt

diff --git a/Documentation/devicetree/bindings/panel/edt,et057090dhu.txt b/Documentation/devicetree/bindings/panel/edt,et057090dhu.txt
new file mode 100644
index 0000000..4903d7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/edt,et057090dhu.txt
@@ -0,0 +1,7 @@
+Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
+
+Required properties:
+- compatible: should be "edt,et057090dhu"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 309f29e..91b4f73 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -306,6 +306,29 @@ static const struct panel_desc chunghwa_claa101wa01a = {
 	},
 };
 
+static const struct drm_display_mode edt_et057090dhu_mode = {
+	.clock = 25175,
+	.hdisplay = 640,
+	.hsync_start = 640 + 16,
+	.hsync_end = 640 + 16 + 30,
+	.htotal = 640 + 16 + 30 + 114,
+	.vdisplay = 480,
+	.vsync_start = 480 + 10,
+	.vsync_end = 480 + 10 + 3,
+	.vtotal = 480 + 10 + 3 + 32,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc edt_et057090dhu = {
+	.modes = &edt_et057090dhu_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 115,
+		.height = 86,
+	},
+};
+
 static const struct drm_display_mode chunghwa_claa101wb01_mode = {
 	.clock = 69300,
 	.hdisplay = 1366,
@@ -383,6 +406,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "chunghwa,claa101wb01",
 		.data = &chunghwa_claa101wb01
 	}, {
+		.compatible = "edt,et057090dhu",
+		.data = &edt_et057090dhu,
+	}, {
 		.compatible = "lg,lp129qe",
 		.data = &lg_lp129qe,
 	}, {
-- 
1.9.2
