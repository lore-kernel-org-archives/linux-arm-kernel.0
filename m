From: Eugen.Hristev@microchip.com (Eugen.Hristev at microchip.com)
Date: Wed, 21 Nov 2018 08:48:02 +0000
Subject: [PATCH 3/3] drm/panel: simple: add support for PDA 91-00156-A0 panel
In-Reply-To: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
Message-ID: <1542789804-4584-4-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
AC320005-5).

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5fbee83..3fc9d0b 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1984,6 +1984,30 @@ static const struct panel_desc ortustech_com43h4m85ulc = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_POSEDGE,
 };
 
+static const struct drm_display_mode pda_91_00156_a0_mode = {
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
+static const struct panel_desc pda_91_00156_a0  = {
+	.modes = &pda_91_00156_a0_mode,
+	.num_modes = 1,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+};
+
+
 static const struct drm_display_mode qd43003c0_40_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -2659,6 +2683,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "ortustech,com43h4m85ulc",
 		.data = &ortustech_com43h4m85ulc,
 	}, {
+		.compatible = "pda,91-00156-a0",
+		.data = &pda_91_00156_a0,
+	}, {
 		.compatible = "qiaodian,qd43003c0-40",
 		.data = &qd43003c0_40,
 	}, {
-- 
2.7.4
