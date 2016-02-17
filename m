From: jitao.shi@mediatek.com (Jitao Shi)
Date: Wed, 17 Feb 2016 14:50:39 +0800
Subject: [PATCH 2/2] drm/panel: Add support for LG lp120up1 panel
In-Reply-To: <1455691839-2410-1-git-send-email-jitao.shi@mediatek.com>
References: <1455691839-2410-1-git-send-email-jitao.shi@mediatek.com>
Message-ID: <1455691839-2410-2-git-send-email-jitao.shi@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LG lp120up1 panel is a 12.0" 1920x1280 panel,
which can be supported by the simple panel driver

Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
---
 drivers/gpu/drm/panel/panel-simple.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index f88a631..2030c37 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -982,6 +982,29 @@ static const struct panel_desc lg_lb070wv8 = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
 };
 
+static const struct drm_display_mode lg_lp120up1_mode = {
+	.clock = 162300,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 40,
+	.hsync_end = 1920 + 40 + 40,
+	.htotal = 1920 + 40 + 40+ 80,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 4,
+	.vsync_end = 1280 + 4 + 4,
+	.vtotal = 1280 + 4 + 4 + 12,
+	.vrefresh = 60,
+};
+
+static const struct panel_desc lg_lp120up1 = {
+	.modes = &lg_lp120up1_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 267,
+		.height = 183,
+	},
+};
+
 static const struct drm_display_mode lg_lp129qe_mode = {
 	.clock = 285250,
 	.hdisplay = 2560,
@@ -1256,6 +1279,9 @@ static const struct of_device_id platform_of_match[] = {
 		.compatible = "lg,lb070wv8",
 		.data = &lg_lb070wv8,
 	}, {
+		.compatible = "lg,lp120up1",
+		.data = &lg_lp120up1,
+	}, {
 		.compatible = "lg,lp129qe",
 		.data = &lg_lp129qe,
 	}, {
-- 
1.7.9.5
