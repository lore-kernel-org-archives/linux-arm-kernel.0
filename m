From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 14:43:00 +0100
Subject: [PATCH 1/2] drm/panel: simple: Add support for Shelly SCA07010-BFN-LNN
Message-ID: <c661ab7f0d1829c7cac7875ce44eb3293a7515a9.1426772560.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

The Shelly SCA07010-BFN-LNN is a 7.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 7" LCD screen (TM70xx series for
instance).

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../bindings/panel/shelly,sca07010-bfn-lnn.txt     |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/shelly,sca07010-bfn-lnn.txt

diff --git a/Documentation/devicetree/bindings/panel/shelly,sca07010-bfn-lnn.txt b/Documentation/devicetree/bindings/panel/shelly,sca07010-bfn-lnn.txt
new file mode 100644
index 000000000000..fc1ea9e26c94
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/shelly,sca07010-bfn-lnn.txt
@@ -0,0 +1,7 @@
+Shelly SCA07010-BFN-LNN 7.0" WVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "shelly,sca07010-bfn-lnn"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3e9aa628169c..6e4a85f50d71 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -802,6 +802,29 @@ static const struct panel_desc samsung_ltn101nt05 = {
 	},
 };
 
+static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode = {
+	.clock = 33300,
+	.hdisplay = 800,
+	.hsync_start = 800 + 1,
+	.hsync_end = 800 + 1 + 64,
+	.htotal = 800 + 1 + 64 + 64,
+	.vdisplay = 480,
+	.vsync_start = 480 + 1,
+	.vsync_end = 480 + 1 + 23,
+	.vtotal = 480 + 1 + 23 + 22,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc shelly_sca07010_bfn_lnn = {
+	.modes = &shelly_sca07010_bfn_lnn_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "auo,b101aw03",
@@ -867,6 +890,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "samsung,ltn101nt05",
 		.data = &samsung_ltn101nt05,
 	}, {
+		.compatible = "shelly,sca07010-bfn-lnn",
+		.data = &shelly_sca07010_bfn_lnn,
+	}, {
 		/* sentinel */
 	}
 };
-- 
2.1.3
