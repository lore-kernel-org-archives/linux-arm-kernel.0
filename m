From: gianlucarenzi@eurekelettronica.it (gianluca)
Date: Mon, 08 Mar 2010 15:32:21 +0100
Subject: Query abut 2410 LCD configuration
In-Reply-To: <tencent_2B5575C569651C571622EABD@qq.com>
References: <tencent_2B5575C569651C571622EABD@qq.com>
Message-ID: <4B950A75.2020107@eurekelettronica.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

??? wrote:
> Hi all:)
> 
>       In arch/arm/mach-s3c2410/include/mach/fb.h, struct s3c2410fb_display defines lcd configurations, 
>       Can figure out where does these values following pixclock come from?
> 
> 
> /* LCD description */
> struct s3c2410fb_display {
> 	/* LCD type */
> 	unsigned type;
> 
> 	/* Screen size */
> 	unsigned short width;
> 	unsigned short height;
> 
> 	/* Screen info */
> 	unsigned short xres;
> 	unsigned short yres;
> 	unsigned short bpp;
> 
> 	unsigned pixclock;		/* pixclock in picoseconds */
> 	unsigned short left_margin;  /* value in pixels (TFT) or HCLKs (STN) */
> 	unsigned short right_margin; /* value in pixels (TFT) or HCLKs (STN) */
> 	unsigned short hsync_len;    /* value in pixels (TFT) or HCLKs (STN) */
> 	unsigned short upper_margin;	/* value in lines (TFT) or 0 (STN) */
> 	unsigned short lower_margin;	/* value in lines (TFT) or 0 (STN) */
> 	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) */
> 
> 	/* lcd configuration registers */
> 	unsigned long	lcdcon5;
> };
> 
> 
> 
>       Take LQ080V3DG01 for example,
> 
> -----------------             arch/arm/mach-s3c2410/mach-qt2410.c     ----------------------------
> 		/* Configuration for 640x480 SHARP LQ080V3DG01 */
> 		.lcdcon5 = S3C2410_LCDCON5_FRM565 |
> 			   S3C2410_LCDCON5_INVVLINE |
> 			   S3C2410_LCDCON5_INVVFRAME |
> 			   S3C2410_LCDCON5_PWREN |
> 			   S3C2410_LCDCON5_HWSWP,
> 
> 		.type		= S3C2410_LCDCON1_TFT,
> 		.width		= 640,
> 		.height		= 480,
> 
> 		.pixclock	= 40000, /* HCLK/4 */
> 		.xres		= 640,
> 		.yres		= 480,
> 		.bpp		= 16,
> 		.left_margin	= 44,
> 		.right_margin	= 116,
> 		.hsync_len	= 96,
> 		.upper_margin	= 19,
> 		.lower_margin	= 11,
> 		.vsync_len	= 15,
> 	},
> 
> pixclock is 40000 in picoseconds , 1/(40000*10^-12) = 25MHz, that correspond with LQ080V3DG01 clock frequency ranges.
> 
> wondering where does the rest of values come from?
> any tips/ideas would be appreciated!
Maybe the LQ080... datasheet? or other platform driver with the same LCD 
configuration, or they simply came from tests.


Regards,
-- 
            ,,,
           (o o)
======oOO==(_)==OOo======

Gianluca Renzi
R&D
phone: +39.0542.609120
fax:   +39.0542.609212

       .oooO  Oooo.
======(   )==(   )=======
        \ (    ) /
         \_)  (_/
