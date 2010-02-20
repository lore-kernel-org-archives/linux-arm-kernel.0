From: tony@atomide.com (Tony Lindgren)
Date: Fri, 19 Feb 2010 16:10:28 -0800
Subject: [PATCH 03/11] arm: omap: musb: ioremap only what's ours
In-Reply-To: <A24693684029E5489D1D202277BE894453691663@dlee02.ent.ti.com>
References: <20100219232648.10559.380.stgit@baageli.muru.com>
	<20100219233019.10559.71005.stgit@baageli.muru.com>
	<A24693684029E5489D1D202277BE89445369164A@dlee02.ent.ti.com>
	<20100219234414.GH21755@atomide.com>
	<A24693684029E5489D1D202277BE894453691663@dlee02.ent.ti.com>
Message-ID: <20100220001028.GJ21755@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aguirre, Sergio <saaguirre@ti.com> [100219 15:52]:
> Hi Tony,
> 
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony at atomide.com]
> > Sent: Friday, February 19, 2010 5:44 PM
> > To: Aguirre, Sergio
> > Cc: linux-arm-kernel at lists.infradead.org; Felipe Balbi; linux-
> > omap at vger.kernel.org; linux-usb at vger.kernel.org
> > Subject: Re: [PATCH 03/11] arm: omap: musb: ioremap only what's ours
> > 
> > * Aguirre, Sergio <saaguirre@ti.com> [100219 15:34]:
> > > Hi,
> > >
> > > > -----Original Message-----
> > > > From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> > > > owner at vger.kernel.org] On Behalf Of Tony Lindgren
> > > > Sent: Friday, February 19, 2010 5:30 PM
> > > > To: linux-arm-kernel at lists.infradead.org
> > > > Cc: Felipe Balbi; linux-omap at vger.kernel.org; linux-
> > usb at vger.kernel.org
> > > > Subject: [PATCH 03/11] arm: omap: musb: ioremap only what's ours
> > > >
> > > > From: Felipe Balbi <felipe.balbi@nokia.com>
> > > >
> > > > omap3430 TRM says the OTG address space is 4k, not 8k.
> > > >
> > > > Cc: linux-usb at vger.kernel.org
> > > > Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > > ---
> > > >  arch/arm/mach-omap2/usb-musb.c |    2 +-
> > > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> > > > musb.c
> > > > index a80441d..ba71f76 100644
> > > > --- a/arch/arm/mach-omap2/usb-musb.c
> > > > +++ b/arch/arm/mach-omap2/usb-musb.c
> > > > @@ -152,7 +152,7 @@ void __init usb_musb_init(void)
> > > >  		musb_resources[0].start = OMAP243X_HS_BASE;
> > > >  	else
> > > >  		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
> > > > -	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
> > > > +	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
> > >
> > > I'm just curious...
> > >
> > > Is this valid also if cpu_is_243x() ?
> > 
> > Yes, the other 4K is for the L4 interconnect.
> 
> Ok...
> 
> But then in this case, shouldn't these register boundaries come from a platform specific header file?
> 
> That would be cleaner, I believe, and easier to maintain in the long run.
> 
> What do you think?

Yeah that will eventually get sorted out by hwmod.

Tony
