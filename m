From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 5 Apr 2011 14:47:55 +0800
Subject: [PATCH] video: mxsfb: correct typo 'FAILING' to 'FALLING'
In-Reply-To: <20110404150430.GB13963@pengutronix.de>
References: <20110404150430.GB13963@pengutronix.de>
Message-ID: <1301986075-3168-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
The patch should probably be split into two to separate machine code
changes from driver ones, but that will result in build failure,
which could be a problem for bisect, so I keep them as one patch.  

 arch/arm/mach-mxs/include/mach/mxsfb.h |    2 +-
 arch/arm/mach-mxs/mach-mx23evk.c       |    2 +-
 arch/arm/mach-mxs/mach-mx28evk.c       |    2 +-
 drivers/video/mxsfb.c                  |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mxsfb.h b/arch/arm/mach-mxs/include/mach/mxsfb.h
index e4d7979..491787e 100644
--- a/arch/arm/mach-mxs/include/mach/mxsfb.h
+++ b/arch/arm/mach-mxs/include/mach/mxsfb.h
@@ -25,7 +25,7 @@
 #define STMLCDIF_24BIT 3 /** pixel data bus to the display is of 24 bit width */
 
 #define FB_SYNC_DATA_ENABLE_HIGH_ACT	(1 << 6)
-#define FB_SYNC_DOTCLK_FAILING_ACT	(1 << 7) /* failing/negtive edge sampling */
+#define FB_SYNC_DOTCLK_FALLING_ACT	(1 << 7) /* falling/negtive edge sampling */
 
 struct mxsfb_platform_data {
 	struct fb_videomode *mode_list;
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 214e5b6..bcf24c1 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -122,7 +122,7 @@ static struct fb_videomode mx23evk_video_modes[] = {
 		.hsync_len	= 1,
 		.vsync_len	= 1,
 		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
+				  FB_SYNC_DOTCLK_FALLING_ACT,
 	},
 };
 
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index bb329b9..9753e85 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -311,7 +311,7 @@ static struct fb_videomode mx28evk_video_modes[] = {
 		.hsync_len	= 10,
 		.vsync_len	= 10,
 		.sync		= FB_SYNC_DATA_ENABLE_HIGH_ACT |
-				  FB_SYNC_DOTCLK_FAILING_ACT,
+				  FB_SYNC_DOTCLK_FALLING_ACT,
 	},
 };
 
diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 7d02848..aa27231 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -103,7 +103,7 @@
 #define VDCTRL0_ENABLE_PRESENT		(1 << 28)
 #define VDCTRL0_VSYNC_ACT_HIGH		(1 << 27)
 #define VDCTRL0_HSYNC_ACT_HIGH		(1 << 26)
-#define VDCTRL0_DOTCLK_ACT_FAILING	(1 << 25)
+#define VDCTRL0_DOTCLK_ACT_FALLING	(1 << 25)
 #define VDCTRL0_ENABLE_ACT_HIGH		(1 << 24)
 #define VDCTRL0_VSYNC_PERIOD_UNIT	(1 << 21)
 #define VDCTRL0_VSYNC_PULSE_WIDTH_UNIT	(1 << 20)
@@ -453,8 +453,8 @@ static int mxsfb_set_par(struct fb_info *fb_info)
 		vdctrl0 |= VDCTRL0_VSYNC_ACT_HIGH;
 	if (fb_info->var.sync & FB_SYNC_DATA_ENABLE_HIGH_ACT)
 		vdctrl0 |= VDCTRL0_ENABLE_ACT_HIGH;
-	if (fb_info->var.sync & FB_SYNC_DOTCLK_FAILING_ACT)
-		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FAILING;
+	if (fb_info->var.sync & FB_SYNC_DOTCLK_FALLING_ACT)
+		vdctrl0 |= VDCTRL0_DOTCLK_ACT_FALLING;
 
 	writel(vdctrl0, host->base + LCDC_VDCTRL0);
 
-- 
1.7.1
