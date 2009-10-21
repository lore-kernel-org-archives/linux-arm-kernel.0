From: shinel@foxmail.com (Shine Liu)
Date: Wed, 21 Oct 2009 18:13:03 +0800
Subject: [PATCH] ARM:S3C2440: MINI2440 Remove some improper __initdata
	qualifiers
In-Reply-To: <200910211129.26044.jbe@pengutronix.de>
References: <1256095984.1600.109.camel@shinel>
	<200910211129.26044.jbe@pengutronix.de>
Message-ID: <1256119983.1940.11.camel@shinel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-10-21 at 11:29 +0200, Juergen Beisert wrote:

> > -struct s3c2410fb_mach_info mini2440_fb_info __initdata = {
> > +struct s3c2410fb_mach_info mini2440_fb_info = {
> >  	.displays	 = &mini2440_lcd_cfg[0], /* not constant! see init */
> >  	.num_displays	 = 1,
> >  	.default_display = 0,
> 
> But the other implementations in this directory are also using __initdata for 
> these structures. Do they also need to remove the __initdata?

You are right. This __initdata should be kept :)
This data will be used in the function s3c24xx_fb_set_platdata which
uses memcpy to make a local copy. 

> >
> > -static struct platform_device *mini2440_devices[] __initdata = {
> > +static struct platform_device *mini2440_devices[] = {
> 
> You can keep this __initdata. mini2440_devices[] its used only once from a 
> __init marked function.
> 

This also should be maked as __initdata.

Thanks.



Best Regards,

Shine Liu 
