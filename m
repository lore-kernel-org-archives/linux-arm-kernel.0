From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed,  6 Jul 2016 15:59:16 -0700
Subject: [REPOST v3 1/2] drm/panel: simple: Add support for Sharp LQ101K1LY04
Message-ID: <1467845957-29036-1-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-panel support for the  Sharp LQ101K1LY04i, which  is
a 10 inch WXGA (1280x800) lvds panel.

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 Reposting again in hopes of getting this into 4.8

 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3a7bdf1..c2d377c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1270,6 +1270,30 @@ static const struct panel_desc samsung_ltn140at29_301 = {
 	},
 };
 
+static const struct display_timing sharp_lq101k1ly04_timing = {
+	.pixelclock = { 60000000, 65000000, 80000000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 20, 20, 20 },
+	.hback_porch = { 20, 20, 20 },
+	.hsync_len = { 10, 10, 10 },
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 4, 4, 4 },
+	.vback_porch = { 4, 4, 4 },
+	.vsync_len = { 4, 4, 4 },
+	.flags = DISPLAY_FLAGS_PIXDATA_POSEDGE,
+};
+
+static const struct panel_desc sharp_lq101k1ly04 = {
+	.timings = &sharp_lq101k1ly04_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+};
+
 static const struct drm_display_mode shelly_sca07010_bfn_lnn_mode = {
 	.clock = 33300,
 	.hdisplay = 800,
@@ -1487,6 +1511,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "samsung,ltn140at29-301",
 		.data = &samsung_ltn140at29_301,
 	}, {
+		.compatible = "sharp,lq101k1ly04",
+		.data = &sharp_lq101k1ly04,
+	}, {
 		.compatible = "shelly,sca07010-bfn-lnn",
 		.data = &shelly_sca07010_bfn_lnn,
 	}, {
-- 
2.7.4
