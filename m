From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Fri,  8 Oct 2010 10:58:06 +0200
Subject: [PATCH] eukrea_mbimxsd: add support for DVI displays
Message-ID: <1286528286-6344-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
 arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c |   32 +++++++++++++++++++++
 arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c  |   38 +++++++++++++++++++++++-
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
index f4c4c6f..1f74888 100644
--- a/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx25/eukrea_mbimxsd-baseboard.c
@@ -117,6 +117,38 @@ static struct imx_fb_videomode eukrea_mximxsd_modes[] = {
 		},
 		.bpp	= 16,
 		.pcr	= 0xCAD08B80,
+	}, {
+		.mode = {
+			.name		= "DVI-VGA",
+			.refresh	= 60,
+			.xres		= 640,
+			.yres		= 480,
+			.pixclock	= 32000,
+			.hsync_len	= 7,
+			.left_margin	= 100,
+			.right_margin	= 100,
+			.vsync_len	= 7,
+			.upper_margin	= 7,
+			.lower_margin	= 100,
+		},
+		.pcr		= 0xFA208B80,
+		.bpp		= 16,
+	}, {
+		.mode = {
+			.name		= "DVI-SVGA",
+			.refresh	= 60,
+			.xres		= 800,
+			.yres		= 600,
+			.pixclock	= 25000,
+			.hsync_len	= 7,
+			.left_margin	= 75,
+			.right_margin	= 75,
+			.vsync_len	= 7,
+			.upper_margin	= 7,
+			.lower_margin	= 75,
+		},
+		.pcr		= 0xFA208B80,
+		.bpp		= 16,
 	},
 };
 
diff --git a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
index 0d219bb..76c5ae4 100644
--- a/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
+++ b/arch/arm/mach-mx3/eukrea_mbimxsd-baseboard.c
@@ -50,7 +50,7 @@
 
 static const struct fb_videomode fb_modedb[] = {
 	{
-		.name		= "CMO_QVGA",
+		.name		= "CMO-QVGA",
 		.refresh	= 60,
 		.xres		= 320,
 		.yres		= 240,
@@ -65,6 +65,40 @@ static const struct fb_videomode fb_modedb[] = {
 		.vmode		= FB_VMODE_NONINTERLACED,
 		.flag		= 0,
 	},
+	{
+		.name		= "DVI-VGA",
+		.refresh	= 60,
+		.xres		= 640,
+		.yres		= 480,
+		.pixclock	= 32000,
+		.left_margin	= 100,
+		.right_margin	= 100,
+		.upper_margin	= 7,
+		.lower_margin	= 100,
+		.hsync_len	= 7,
+		.vsync_len	= 7,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT |
+				  FB_SYNC_OE_ACT_HIGH | FB_SYNC_CLK_INVERT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
+	{
+		.name		= "DVI-SVGA",
+		.refresh	= 60,
+		.xres		= 800,
+		.yres		= 600,
+		.pixclock	= 25000,
+		.left_margin	= 75,
+		.right_margin	= 75,
+		.upper_margin	= 7,
+		.lower_margin	= 75,
+		.hsync_len	= 7,
+		.vsync_len	= 7,
+		.sync		= FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT |
+				  FB_SYNC_OE_ACT_HIGH | FB_SYNC_CLK_INVERT,
+		.vmode		= FB_VMODE_NONINTERLACED,
+		.flag		= 0,
+	},
 };
 
 static struct ipu_platform_data mx3_ipu_data = {
@@ -73,7 +107,7 @@ static struct ipu_platform_data mx3_ipu_data = {
 
 static struct mx3fb_platform_data mx3fb_pdata = {
 	.dma_dev	= &mx3_ipu.dev,
-	.name		= "CMO_QVGA",
+	.name		= "CMO-QVGA",
 	.mode		= fb_modedb,
 	.num_modes	= ARRAY_SIZE(fb_modedb),
 };
-- 
1.7.0.4
