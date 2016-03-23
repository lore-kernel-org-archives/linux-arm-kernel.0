From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Mar 2016 17:38:34 +0100
Subject: [PATCH v3 11/19] drm/panel: simple: Add timings for the Olimex
 LCD-OLinuXino-4.3TS
In-Reply-To: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1458751122-23976-12-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the Olimex LCD-OLinuXino-4.3TS panel to the DRM simple
panel driver.

It is a 480x272 panel connected through a 24-bits RGB interface.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../display/panel/olimex,lcd-olinuxino-43-ts.txt   |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt

diff --git a/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt
new file mode 100644
index 000000000000..74540a090669
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/olimex,lcd-olinuxino-43-ts.txt
@@ -0,0 +1,7 @@
+Olimex 4.3" TFT LCD panel
+
+Required properties:
+- compatible: should be "olimex,lcd-olinuxino-43-ts"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index ceb20486dacf..f95abdbde147 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1084,6 +1084,29 @@ static const struct panel_desc okaya_rs800480t_7x0gp = {
 	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
 };
 
+static const struct drm_display_mode olimex_lcd_olinuxino_43ts_mode = {
+	.clock = 9000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 5,
+	.hsync_end = 480 + 5 + 30,
+	.htotal = 480 + 5 + 30 + 10,
+	.vdisplay = 272,
+	.vsync_start = 272 + 8,
+	.vsync_end = 272 + 8 + 5,
+	.vtotal = 272 + 8 + 5 + 3,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc olimex_lcd_olinuxino_43ts = {
+	.modes = &olimex_lcd_olinuxino_43ts_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 105,
+		.height = 67,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct drm_display_mode ortustech_com43h4m85ulc_mode  = {
 	.clock = 25000,
 	.hdisplay = 480,
@@ -1329,6 +1352,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "okaya,rs800480t-7x0gp",
 		.data = &okaya_rs800480t_7x0gp,
 	}, {
+		.compatible = "olimex,lcd-olinuxino-43-ts",
+		.data = &olimex_lcd_olinuxino_43ts,
+	}, {
 		.compatible = "ortustech,com43h4m85ulc",
 		.data = &ortustech_com43h4m85ulc,
 	}, {
-- 
2.7.3
