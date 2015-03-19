From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Mar 2015 14:43:01 +0100
Subject: [PATCH 2/2] drm/panel: simple: Add support for Innolux AT043TN24
In-Reply-To: <c661ab7f0d1829c7cac7875ce44eb3293a7515a9.1426772560.git.nicolas.ferre@atmel.com>
References: <c661ab7f0d1829c7cac7875ce44eb3293a7515a9.1426772560.git.nicolas.ferre@atmel.com>
Message-ID: <84ca8ea51cd7bd709729de927d60d8a2f47664c7.1426772560.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Innolux AT043TN24 4.3" WQVGA TFT LCD panel.
This panel with backlight is found in PDA 4.3" LCD screen (TM43xx series for
instance).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../bindings/panel/innolux,at043tn24.txt           |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/panel/innolux,at043tn24.txt

diff --git a/Documentation/devicetree/bindings/panel/innolux,at043tn24.txt b/Documentation/devicetree/bindings/panel/innolux,at043tn24.txt
new file mode 100644
index 000000000000..4104226b61bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/panel/innolux,at043tn24.txt
@@ -0,0 +1,7 @@
+Innolux AT043TN24 4.3" WQVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "innolux,at043tn24"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 6e4a85f50d71..4088f9bd7973 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -663,6 +663,31 @@ static const struct panel_desc hitachi_tx23d38vm0caa = {
 	},
 };
 
+static const struct drm_display_mode innolux_at043tn24_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 2,
+	.hsync_end = 480 + 2 + 41,
+	.htotal = 480 + 2 + 41 + 2,
+	.vdisplay = 272,
+	.vsync_start = 272 + 2,
+	.vsync_end = 272 + 2 + 11,
+	.vtotal = 272 + 2 + 11 + 2,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct panel_desc innolux_at043tn24 = {
+	.modes = &innolux_at043tn24_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+};
+
 static const struct drm_display_mode innolux_g121i1_l01_mode = {
 	.clock = 71000,
 	.hdisplay = 1280,
@@ -872,6 +897,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "hit,tx23d38vm0caa",
 		.data = &hitachi_tx23d38vm0caa
 	}, {
+		.compatible = "innolux,at043tn24",
+		.data = &innolux_at043tn24,
+	}, {
 		.compatible ="innolux,g121i1-l01",
 		.data = &innolux_g121i1_l01
 	}, {
-- 
2.1.3
