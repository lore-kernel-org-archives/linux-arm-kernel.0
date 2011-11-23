From: linux@solonet.org.ua (Denis Kuzmenko)
Date: Wed, 23 Nov 2011 20:11:27 +0200
Subject: [PATCH resend] arm: s3c24xx: Add new LCD (W35i) support for Mini2440
 board
In-Reply-To: <4EC588A8.3030907@solonet.org.ua>
References: <4EC588A8.3030907@solonet.org.ua>
Message-ID: <4ECD374F.5060208@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new LCD (W35i) support for Mini2440 board

Signed-off-by: Denis Kuzmenko <linux@solonet.org.ua>
---

I need to refer this patch but can't find it on lkml.org
Maybe I haven't send it...
Sorry for bothering if I did so.

diff --git a/arch/arm/mach-s3c2440/mach-mini2440.c b/arch/arm/mach-s3c2440/mach-mini2440.c
index fc2dc0b..951eadd 100644
--- a/arch/arm/mach-s3c2440/mach-mini2440.c
+++ b/arch/arm/mach-s3c2440/mach-mini2440.c
@@ -167,6 +167,24 @@ static struct s3c2410fb_display mini2440_lcd_cfg[] __initdata = {
 		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
 				   S3C2410_LCDCON5_HWSWP),
 	},
+	/* mini2440 + 3.5" TFT (LCD-W35i, LQ035Q1DG06 type) + touchscreen*/
+	[3] = {
+		_LCD_DECLARE(
+			/* clock */
+			7,
+			/* xres, margin_right, margin_left, hsync */
+			320, 68, 66, 4,
+			/* yres, margin_top, margin_bottom, vsync */
+			240, 4, 4, 9,
+			/* refresh rate */
+			60),
+		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
+				   S3C2410_LCDCON5_INVVDEN |
+				   S3C2410_LCDCON5_INVVFRAME |
+				   S3C2410_LCDCON5_INVVLINE |
+				   S3C2410_LCDCON5_INVVCLK |
+				   S3C2410_LCDCON5_HWSWP),
+	},
 };
 
 /* todo - put into gpio header */
