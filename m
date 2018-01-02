From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue,  2 Jan 2018 14:32:17 +0530
Subject: [PATCH 4/5] drm/panel: simple: Add support for KEO TX31D200VM0BAA
In-Reply-To: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
References: <1514883738-16297-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1514883738-16297-4-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Kaohsiung Opto-Electronics.,
TX31D200VM0BAA 12.3" HSXGA LVDS panel, which can be
supported by the simple panel driver.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../bindings/display/panel/koe,tx31d200vm0baa.txt  |  7 ++++++
 drivers/gpu/drm/panel/panel-simple.c               | 27 ++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt

diff --git a/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt b/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
new file mode 100644
index 0000000..a51db2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/koe,tx31d200vm0baa.txt
@@ -0,0 +1,7 @@
+Kaohsiung Opto-Electronics. TX31D200VM0BAA 12.3" HSXGA LVDS panel
+
+Required properties:
+- compatible: should be "koe,tx31d200vm0baa"
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 2ecc14b..8a0e4a8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1241,6 +1241,30 @@ static const struct panel_desc innolux_zj070na_01p = {
 	},
 };
 
+static const struct display_timing koe_tx31d200vm0baa_timing = {
+	.pixelclock = { 39600000, 43200000, 48000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 16, 36, 56 },
+	.hback_porch = { 16, 36, 56 },
+	.hsync_len = { 8, 8, 8 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 6, 21, 33.5 },
+	.vback_porch = { 6, 21, 33.5 },
+	.vsync_len = { 8, 8, 8 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc koe_tx31d200vm0baa = {
+	.timings = &koe_tx31d200vm0baa_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 292,
+		.height = 109,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
+};
+
 static const struct display_timing kyo_tcg121xglp_timing = {
 	.pixelclock = { 52000000, 65000000, 71000000 },
 	.hactive = { 1024, 1024, 1024 },
@@ -2151,6 +2175,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
 	}, {
+		.compatible = "koe,tx31d200vm0baa",
+		.data = &koe_tx31d200vm0baa,
+	}, {
 		.compatible = "kyo,tcg121xglp",
 		.data = &kyo_tcg121xglp,
 	}, {
-- 
2.7.4
