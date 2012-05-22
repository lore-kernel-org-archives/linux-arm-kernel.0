From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 16:07:31 +0200
Subject: [PATCH v2 02/12] usb: chipidea: permit driver bindings pass phy
 pointer
In-Reply-To: <87ehqcbko0.fsf@ashishki-desk.ger.corp.intel.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-3-git-send-email-richard.zhao@freescale.com>
 <87ehqcbko0.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <201205221607.31624.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alexander Shishkin,

> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> Hi,
> 
> > Sometimes, the driver bindings may know what phy they use.
> > For example, when using device tree, the usb controller may have a
> > phandler pointing to usb phy.
> 
> Some comments below:
> 
> [snip]
> 
> >  	ci->dev = dev;
> >  	ci->udc_driver = dev->platform_data;
> > 
> > +	if (ci->udc_driver->phy)
> > +		ci->transceiver = ci->udc_driver->phy;
> > +	else
> > +		ci->global_phy = 1;
> 
> Nitpick: since it's a bool, don't you want to use "true" instead?
> 
> [snip]
> 
> > +#include <linux/usb/otg.h>
> > +
> > 
> >  struct ci13xxx;
> >  struct ci13xxx_udc_driver {
> >  
> >  	const char	*name;
> >  	/* offset of the capability registers */
> >  	uintptr_t	 capoffset;
> >  	unsigned	 power_budget;
> > 
> > +	struct usb_phy	*phy;
> 
> This structure is really platform information, not per-device
> instance. Consider, for example, situation when you have 2 controllers
> in one system, they'll be using the same platform structure, but they'll
> have different phys. Right?

Not really, won't you allocate separate structure for them?

> 
> Regards,
> --
> Alex

Best regards,
Marek Vasut
