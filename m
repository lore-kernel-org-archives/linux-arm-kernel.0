From: jbe@pengutronix.de (Juergen Beisert)
Date: Sun,  8 Jul 2012 19:12:17 +0200
Subject: [PATCH 03/10] MACH/Samsung/Mini2440: add support for new LCD panels.
In-Reply-To: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
References: <1341767544-17447-1-git-send-email-jbe@pengutronix.de>
Message-ID: <1341767544-17447-4-git-send-email-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marek Belisko <marek.belisko@open-nandra.com>

This patch add support for new mini2440 board LCD's:
3.5" TFT + TS (TD035STED4)
5.6" TFT (Innolux AT056TN52).
3.5" TFT + TS (SONY X35)

Values overtaken from mini2440 kernel:
git://repo.or.cz/linux-2.6/mini2440.git
and https://github.com/a1ien/mini2440-linux-kernel

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
Acked-by: Juergen Beisert <jbe@pengutronix.de>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c |   50 +++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index f092b18..45d5bb5 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -187,6 +187,56 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 				   S3C2410_LCDCON5_INVVCLK |
 				   S3C2410_LCDCON5_HWSWP),
 	},
+	[4] = {	/* mini2440 + 3.5" TFT + TS -- New model as Nov 2009 "T35" */
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
+	[5] = { /* mini2440 + 5.6" TFT + touchscreen -- Innolux AT056TN52 */
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
+	[6] = { /* mini2440 + 3,5" TFT + touchscreen -- SONY X35 */
+		_LCD_DECLARE(
+			7,
+			240, 1, 26, 5,		/* x timing */
+			320, 1, 5, 9,		/* y timing */
+			60),			/* refresh rate */
+		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
+					S3C2410_LCDCON5_INVVDEN |
+					S3C2410_LCDCON5_INVVFRAME |
+					S3C2410_LCDCON5_INVVLINE |
+					S3C2410_LCDCON5_INVVCLK |
+					S3C2410_LCDCON5_HWSWP),
+	},
+	[7] = { /* mini2440 + 4.3" TFT + touchscreen (NEC NL4827HC19-01B: N43)
+		   mini2440 + 4.3" TFT + touchscreen (SHARP LQ043T3DX02: N43i) */
+		_LCD_DECLARE(
+			9,		/* clock rate */
+			480, 19, 38, 6,	/* xres, margin_right, margin_left, hsync */
+			272, 1, 1, 2,	/* yres, margin_top, margin_bottom, vsync */
+			60),		/* refresh rate */
+		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
+					S3C2410_LCDCON5_INVVFRAME |
+					S3C2410_LCDCON5_INVVLINE |
+					S3C2410_LCDCON5_PWREN |
+					S3C2410_LCDCON5_HWSWP),
+	},
 };
 
 /* todo - put into gpio header */
-- 
1.7.10
