From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 16 Jun 2011 15:34:29 +0400
Subject: [PATCH] arm mach-s3c2440 mach-mini2440: New LCD-W35i support
In-Reply-To: <4DF7C50A.7060602@solonet.org.ua>
References: <4DF7C50A.7060602@solonet.org.ua>
Message-ID: <4DF9EA45.3020101@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 15-06-2011 0:31, Denis Kuzmenko wrote:

>> Need an empty line here...
>> Your patch is line wrapped. Seems easy to fix though...

> Thank you. Is the patch below okay?

    Not yet. :-)

> From: Denis Kuzmenko <dart@solonet.org.ua>

> LCD-W35i support for Mini2440 development board

    Your signoff needs to be here. Sorry -- didn't notice the first time.

> --- linux-2.6.39.1/arch/arm/mach-s3c2440/mach-mini2440.c 2011-06-03
> 03:34:20.000000000 +0300
> +++ linux-2.6.39.1-dart/arch/arm/mach-s3c2440/mach-mini2440.c 2011-06-13
> 23:37:38.785984118 +0300
> @@ -167,6 +167,20 @@ static struct s3c2410fb_display mini2440
> .lcdcon5 = (S3C2410_LCDCON5_FRM565 |
> S3C2410_LCDCON5_HWSWP),
> },
> + /* LCD-W35i 3.5" display (LQ035Q1DG06)*/
> + [3] = {
> + _LCD_DECLARE(
> + 7, /* clock */
> + 320, 68, 66, 4, /* xres, margin_right, margin_left, hsync */
> + 240, 4, 4, 9, /* yres, margin_top, margin_bottom, vsync */
> + 60), /* refresh rate */
> + .lcdcon5 = (S3C2410_LCDCON5_FRM565 |
> + S3C2410_LCDCON5_INVVDEN |
> + S3C2410_LCDCON5_INVVFRAME |
> + S3C2410_LCDCON5_INVVLINE |
> + S3C2410_LCDCON5_INVVCLK |
> + S3C2410_LCDCON5_HWSWP),
> + },
> };

    The patch has all tabs converted to spaces. Didn't notice it the first 
time as well... :-/

WBR, Sergei
