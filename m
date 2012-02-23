From: tony@atomide.com (Tony Lindgren)
Date: Thu, 23 Feb 2012 11:00:26 -0800
Subject: [PATCH] ARM: OMAP: enable Bluetooth on the PandaBoard
In-Reply-To: <201202231512.57684.arnd@arndb.de>
References: <1329990318-4575-1-git-send-email-mgherzan@gmail.com>
 <201202231512.57684.arnd@arndb.de>
Message-ID: <20120223190026.GA18185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120223 06:41]:
> On Thursday 23 February 2012, Mircea Gherzan wrote:
> > The PandaBoard features a Texas Instruments WiLink7 Bluetooth
> > chip, supported by the "btwilink" driver.
> > 
> > Signed-off-by: Mircea Gherzan <mgherzan@gmail.com>
> 
> No objections to the patch, but please send it to the maintainer,
> not to me. You also misspelled the address of the linux-omap
> list, so Tony probably didn't get it there either.

Thanks, seeing the repost now. Will queue it.

Tony
 
> > diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> > index 28fc271..b1d74d6 100644
> > --- a/arch/arm/mach-omap2/board-omap4panda.c
> > +++ b/arch/arm/mach-omap2/board-omap4panda.c
> > @@ -91,9 +91,15 @@ static struct platform_device leds_gpio = {
> >  	},
> >  };
> >  
> > +static struct platform_device btwilink_device = {
> > +	.name	= "btwilink",
> > +	.id	= -1,
> > +};
> > +
> >  static struct platform_device *panda_devices[] __initdata = {
> >  	&leds_gpio,
> >  	&wl1271_device,
> > +	&btwilink_device,
> >  };
> >  
> >  static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
> > -- 
> > 1.7.9.1
> > 
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
