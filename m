From: alex.gonzalez@digi.com (Alex Gonzalez)
Date: Thu, 25 Oct 2018 17:09:30 +0200
Subject: [PATCH v1 1/4] drm/panel: simple: Add AUO G101EVN010 panel support
In-Reply-To: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
References: <1540480173-12009-1-git-send-email-alex.gonzalez@digi.com>
Message-ID: <1540480173-12009-2-git-send-email-alex.gonzalez@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change adds support for the AU Optronics G101EVN010 10.1" TFT LCD
panel.

Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
---
 .../bindings/display/panel/auo,g101evn010          | 12 ++++++++++
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/auo,g101evn010

diff --git a/Documentation/devicetree/bindings/display/panel/auo,g101evn010 b/Documentation/devicetree/bindings/display/panel/auo,g101evn010
new file mode 100644
index 000000000000..bc6a0c858e23
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/auo,g101evn010
@@ -0,0 +1,12 @@
+AU Optronics Corporation 10.1" (1280x800) color TFT LCD panel
+
+Required properties:
+- compatible: should be "auo,g101evn010"
+- power-supply: as specified in the base binding
+
+Optional properties:
+- backlight: as specified in the base binding
+- enable-gpios: as specified in the base binding
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 97964f7f2ace..65a0dd166637 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -631,6 +631,30 @@ static const struct panel_desc auo_g104sn02 = {
 	},
 };
 
+static const struct drm_display_mode auo_g101evn010_mode = {
+	.clock = 68930,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 82,
+	.hsync_end = 1280 + 82 + 2,
+	.htotal = 1280 + 82 + 2 + 84,
+	.vdisplay = 800,
+	.vsync_start = 800 + 8,
+	.vsync_end = 800 + 8 + 2,
+	.vtotal = 800 + 8 + 2 + 6,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc auo_g101evn010 = {
+	.modes = &auo_g101evn010_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 216,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct display_timing auo_g133han01_timings = {
 	.pixelclock = { 134000000, 141200000, 149000000 },
 	.hactive = { 1920, 1920, 1920 },
@@ -2355,6 +2379,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "auo,g104sn02",
 		.data = &auo_g104sn02,
 	}, {
+		.compatible = "auo,g101evn010",
+		.data = &auo_g101evn010,
+	}, {
 		.compatible = "auo,g133han01",
 		.data = &auo_g133han01,
 	}, {
