From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 28 Jun 2016 12:51:15 +0800
Subject: [PATCH v1 2/5] drm/panel: simple: Add support for LG LP079QX1-SP0V
 1536x2048 panel
In-Reply-To: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
References: <1467089288-18355-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1467089475-18627-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LG LP079QX1-SP0V is an 7.9" QXGA TFT with LED Backlight unit and
32 pins eDP interface. This module supports 1536x2048 mode.

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3a7bdf1..072c994 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1017,6 +1017,29 @@ static const struct panel_desc lg_lb070wv8 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 };
 
+static const struct drm_display_mode lg_lp079qx1_sp0v_mode = {
+	.clock = 200000,
+	.hdisplay = 1536,
+	.hsync_start = 1536 + 12,
+	.hsync_end = 1536 + 12 + 16,
+	.htotal = 1536 + 12 + 16 + 48,
+	.vdisplay = 2048,
+	.vsync_start = 2048 + 8,
+	.vsync_end = 2048 + 8 + 4,
+	.vtotal = 2048 + 8 + 4 + 8,
+	.vrefresh = 60,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc lg_lp079qx1_sp0v = {
+	.modes = &lg_lp079qx1_sp0v_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 129,
+		.height = 171,
+	},
+};
+
 static const struct drm_display_mode lg_lp120up1_mode = {
 	.clock = 162300,
 	.hdisplay = 1920,
@@ -1457,6 +1480,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "lg,lb070wv8",
 		.data = &lg_lb070wv8,
 	}, {
+		.compatible = "lg,lp079qx1-sp0v",
+		.data = &lg_lp079qx1_sp0v,
+	}, {
 		.compatible = "lg,lp120up1",
 		.data = &lg_lp120up1,
 	}, {
-- 
1.9.1
