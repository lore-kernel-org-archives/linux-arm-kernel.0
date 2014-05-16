From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 16 May 2014 11:36:14 +0200
Subject: [PATCH] ARM: OMAP: replace checks for CONFIG_USB_GADGET_OMAP
In-Reply-To: <20140515231229.GA25523@saruman.home>
References: <1400187345.11786.28.camel@x220>
 <20140515231229.GA25523@saruman.home>
Message-ID: <1400232974.20342.22.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Thu, 2014-05-15 at 18:12 -0500, Felipe Balbi wrote:
> On Thu, May 15, 2014 at 10:55:45PM +0200, Paul Bolle wrote:
> > diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
> > index 65d2acb31498..57092bc7f4f1 100644
> > --- a/arch/arm/mach-omap1/board-h2.c
> > +++ b/arch/arm/mach-omap1/board-h2.c
> > @@ -346,7 +346,7 @@ static struct omap_usb_config h2_usb_config __initdata = {
> >  	/* usb1 has a Mini-AB port and external isp1301 transceiver */
> >  	.otg		= 2,
> >  
> > -#ifdef	CONFIG_USB_GADGET_OMAP
> > +#ifdef	CONFIG_USB_OMAP
> 
> CONFIG_USB_OMAP is tristate, it might be better to use
> IS_ENABLED(CONFIG_USB_OMAP) here. Likewise for the rest of the patch.

Will do shortly. That does increase the scope of the patch, a bit, but
since this code has been effectively dead since v3.1 that is hardly an
additional risk.

Thanks!


Paul Bolle
