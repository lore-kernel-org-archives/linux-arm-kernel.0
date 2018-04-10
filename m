From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 10 Apr 2018 23:31:27 +0200
Subject: [PATCH 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN92
Message-ID: <20180410213129.24049-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds timings for the RGB666 variant of the Innolux AT070TN92 panel,
as found on the Ainol AW1 tablet.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5591984a392b..efeb2f2162bc 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1063,6 +1063,29 @@ static const struct panel_desc innolux_at070tn92 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode innolux_at070tn92_rgb666_mode = {
+	.clock = 40000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 112,
+	.hsync_end = 800 + 112 + 1,
+	.htotal = 800 + 112 + 1 + 87,
+	.vdisplay = 480,
+	.vsync_start = 480 + 141,
+	.vsync_end = 480 + 141 + 1,
+	.vtotal = 480 + 141 + 1 + 38,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc innolux_at070tn92_rgb666 = {
+	.modes = &innolux_at070tn92_rgb666_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+};
+
 static const struct display_timing innolux_g101ice_l01_timing = {
 	.pixelclock = { 60400000, 71100000, 74700000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -2105,6 +2128,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,at070tn92",
 		.data = &innolux_at070tn92,
+	}, {
+		.compatible = "innolux,at070tn92-rgb666",
+		.data = &innolux_at070tn92_rgb666,
 	}, {
 		.compatible ="innolux,g101ice-l01",
 		.data = &innolux_g101ice_l01
-- 
2.16.3
