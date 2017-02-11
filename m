From: plaes@plaes.org (Priit Laes)
Date: Sat, 11 Feb 2017 19:44:00 +0200
Subject: [PATCH 3/8] drm/panel: simple: Add support for LG LP097x02-slq2 panel
In-Reply-To: <20170211174405.28395-1-plaes@plaes.org>
References: <20170211174405.28395-1-plaes@plaes.org>
Message-ID: <20170211174405.28395-4-plaes@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add simple-panel support for the LG LP097x02-slq2, which is 10"
1024x768 LVDS panel.

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 06aaf79..2948fed 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1205,6 +1205,28 @@ static const struct panel_desc lg_lp097qx1_spa1 = {
 	},
 };
 
+static const struct drm_display_mode lg_lp097x02_slq2_mode = {
+    .clock = 100000,
+    .hdisplay = 1024,
+    .hsync_start = 1024 + 260,
+    .hsync_end = 1024 + 260 + 1,
+    .htotal = 1024 + 260 + 1 + 799,
+    .vdisplay = 768,
+    .vsync_start = 768 + 16,
+    .vsync_end = 768 + 16 + 1,
+    .vtotal = 768 + 16 + 1 + 15,
+    .vrefresh = 60,
+};
+
+static const struct panel_desc lg_lp097x02_slq2 = {
+    .modes = &lg_lp097x02_slq2_mode,
+    .num_modes = 1,
+    .size = {
+        .width = 197,
+        .height = 147,
+    },
+};
+
 static const struct drm_display_mode lg_lp120up1_mode = {
 	.clock = 162300,
 	.hdisplay = 1920,
@@ -1817,6 +1839,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "lg,lp097qx1-spa1",
 		.data = &lg_lp097qx1_spa1,
 	}, {
+		.compatible = "lg,lp097x02-slq2",
+		.data = &lg_lp097x02_slq2,
+	}, {
 		.compatible = "lg,lp120up1",
 		.data = &lg_lp120up1,
 	}, {
-- 
2.9.3
