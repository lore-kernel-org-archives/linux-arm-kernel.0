From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 24 Nov 2010 00:34:07 +0000
Subject: Query abut 2410 LCD configuration
In-Reply-To: <tencent_2B5575C569651C571622EABD@qq.com>
References: <tencent_2B5575C569651C571622EABD@qq.com>
Message-ID: <4CEC5D7F.2040503@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/10 14:24, ??? wrote:
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
> 	unsigned short vsync_len;	/* value in lines (TFT) or 0 (STN) 


these values are generally found from the panel's data sheet, detailing
the size of the borders and the length of the sync pulses. These relate
to the standard framebuffer parameters
