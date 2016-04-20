From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 20 Apr 2016 14:17:59 +0200
Subject: [PATCH] drm/panel: simple: Add support for Innolux AT070TN92
Message-ID: <1461154679-7214-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Riccardo Bortolato <bortolato@navaltechitalia.it>

Add support for the Innolux AT070TN92 panel.

Signed-off-by: Riccardo Bortolato <bortolato@navaltechitalia.it>
---
 .../bindings/display/panel/innolux,at070tn92.txt   |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,at070tn92.txt

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,at070tn92.txt b/Documentation/devicetree/bindings/display/panel/innolux,at070tn92.txt
new file mode 100644
index 0000000..3e10cd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,at070tn92.txt
@@ -0,0 +1,7 @@
+Innolux AT070TN92 7.0" WQVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "innolux,at070tn92"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3649eb0..d321c57 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -822,6 +822,29 @@ static const struct panel_desc innolux_at043tn24 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode innolux_at070tn92_mode = {
+	.clock = 33333,
+	.hdisplay = 800,
+	.hsync_start = 800 + 210,
+	.hsync_end = 800 + 210 + 20,
+	.htotal = 800 + 210 + 20 + 46,
+	.vdisplay = 480,
+	.vsync_start = 480 + 22,
+	.vsync_end = 480 + 22 + 10,
+	.vtotal = 480 + 22 + 23 + 10,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc innolux_at070tn92 = {
+	.modes = &innolux_at070tn92_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+};
+
 static const struct drm_display_mode innolux_g121i1_l01_mode = {
 	.clock = 71000,
 	.hdisplay = 1280,
@@ -1362,6 +1385,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "innolux,at043tn24",
 		.data = &innolux_at043tn24,
 	}, {
+		.compatible = "innolux,at070tn92",
+		.data = &innolux_at070tn92,
+	}, {
 		.compatible ="innolux,g121i1-l01",
 		.data = &innolux_g121i1_l01
 	}, {
-- 
2.5.0
