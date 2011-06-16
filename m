From: list@solonet.org.ua (Denis Kuzmenko)
Date: Thu, 16 Jun 2011 21:35:05 +0300
Subject: [PATCH] arm mach-s3c2440 mach-mini2440: New LCD-W35i support
In-Reply-To: <4DF9EA45.3020101@ru.mvista.com>
References: <4DF7C50A.7060602@solonet.org.ua> <4DF9EA45.3020101@ru.mvista.com>
Message-ID: <4DFA4CD9.9070601@solonet.org.ua>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2011 02:34 PM, Sergei Shtylyov wrote:
> Hello.
> Your signoff needs to be here. Sorry -- didn't notice the first time.
> The patch has all tabs converted to spaces. Didn't notice it the first
> time as well... :-/

Thanks for comments. How about this one?

From: Denis Kuzmenko <dart@solonet.org.ua>
Date: 2011-06-16 21:30:00 +0300

LCD-W35i support for Mini2440 development board

Signed-off-by: Denis Kuzmenko <dart@solonet.org.ua>

--- linux-2.6.39.1/arch/arm/mach-s3c2440/mach-mini2440.c	2011-06-03 
03:34:20.000000000 +0300
+++ linux-2.6.39.1-dart/arch/arm/mach-s3c2440/mach-mini2440.c	2011-06-13 
23:37:38.785984118 +0300
@@ -167,6 +167,20 @@ static struct s3c2410fb_display mini2440
  		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
  				   S3C2410_LCDCON5_HWSWP),
  	},
+	/* LCD-W35i 3.5" display (LQ035Q1DG06)*/
+	[3] = {
+		_LCD_DECLARE(
+			7,		/* clock */
+			320, 68, 66, 4,	/* xres, margin_right, margin_left, hsync */
+			240, 4, 4, 9,	/* yres, margin_top, margin_bottom, vsync */
+			60),		/* refresh rate */
+		.lcdcon5	= (S3C2410_LCDCON5_FRM565 |
+				   S3C2410_LCDCON5_INVVDEN |
+				   S3C2410_LCDCON5_INVVFRAME |
+				   S3C2410_LCDCON5_INVVLINE |
+				   S3C2410_LCDCON5_INVVCLK |
+				   S3C2410_LCDCON5_HWSWP),
+	},
  };

  /* todo - put into gpio header */
