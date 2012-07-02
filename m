From: yegorslists@googlemail.com (yegorslists at googlemail.com)
Date: Mon,  2 Jul 2012 09:11:13 +0200
Subject: [PATCH] da8xx-fb: add missing FB_BLANK operations
Message-ID: <1341213073-2986-1-git-send-email-yegorslists@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yegor Yefremov <yegorslists@googlemail.com>

add FB_BLANK_NORMAL, FB_BLANK_VSYNC_SUSPEND and FB_BLANK_HSYNC_SUSPEND
modes (copy drivers/video/omap2/omapfb/omapfb-main.c implementation).
Otherwise X-server will complain about invalid parameter.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 drivers/video/da8xx-fb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 29577bf..9879edc 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -987,6 +987,9 @@ static int cfb_blank(int blank, struct fb_info *info)
 
 		lcd_enable_raster();
 		break;
+	case FB_BLANK_NORMAL:
+	case FB_BLANK_VSYNC_SUSPEND:
+	case FB_BLANK_HSYNC_SUSPEND:
 	case FB_BLANK_POWERDOWN:
 		if (par->panel_power_ctrl)
 			par->panel_power_ctrl(0);
-- 
1.7.7
