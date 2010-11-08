From: marek.belisko@gmail.com (Marek Belisko)
Date: Mon,  8 Nov 2010 13:39:09 +0100
Subject: [PATCH] ARM: s3c2440: mini2440: Add support for new LCD's.
Message-ID: <1289219949-19958-1-git-send-email-marek.belisko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add support for new mini2440 board LCD's:
3.5" TFT + TS (TD035STED4)
5.6" TFT (Innolux AT056TN52).

Code overtaken from mini2440 kernel:
git://repo.or.cz/linux-2.6/mini2440.git

Signed-off-by: Marek Belisko <marek.belisko@gmail.com>
---
 arch/arm/mach-s3c2440/mach-mini2440.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index f62bb4c..4c11699 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -185,6 +185,30 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
 				   S3C2410_LCDCON5_HWSWP),
 	},
+	[3] = {	/* mini2440 + 3.5" TFT + TS -- New model as Nov 2009 "T35" */
+		_LCD_DECLARE(
+			7,			/* The 3.5 is quite fast */
+			240, 21, 25, 6,		/* x timing */
+			320, 2, 4, 2,		/* y timing */
+			40),			/* refresh rate */
+		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
+				   S3C2410_LCDCON5_INVVLINE |
+				   S3C2410_LCDCON5_INVVFRAME |
+				   S3C2410_LCDCON5_INVVDEN |
+				   S3C2410_LCDCON5_PWREN),
+	},
+	[4] = { /* mini2440 + 5.6" TFT + touchscreen -- Innolux AT056TN52 */
+		/* be sure the "power" jumper is set accordingly ! */
+		_LCD_DECLARE(
+			10,			/* the 5.3" runs slower */
+			640, 41, 68, 22,	/* x timing */
+			480, 26, 6, 2,		/* y timing */
+			40),			/* refresh rate */
+		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
+				   S3C2410_LCDCON5_INVVLINE |
+				   S3C2410_LCDCON5_INVVFRAME |
+				   S3C2410_LCDCON5_PWREN),
+	},
 };
 
 /* todo - put into gpio header */
-- 
1.7.1
