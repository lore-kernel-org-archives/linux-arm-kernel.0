From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Nov 2010 14:31:06 -0700
Subject: [PATCH 1/2] arm: omap1: devices: need to return with a value
In-Reply-To: <20101019080150.GC11713@pengutronix.de>
References: <1287473455-25773-1-git-send-email-balbi@ti.com>
	<1287473455-25773-2-git-send-email-balbi@ti.com>
	<20101019080150.GC11713@pengutronix.de>
Message-ID: <20101105213106.GV9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> [101019 00:53]:
> On Tue, Oct 19, 2010 at 10:30:54AM +0300, Felipe Balbi wrote:
> > Get rid of the following warning:
> > 
> > arch/arm/mach-omap1/devices.c: In function 'omap_init_wdt':
> > arch/arm/mach-omap1/devices.c:298: warning: 'return' with
> > no value, in function returning non-void
> > 
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  arch/arm/mach-omap1/devices.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> > index 63d68cf..a037aba 100644
> > --- a/arch/arm/mach-omap1/devices.c
> > +++ b/arch/arm/mach-omap1/devices.c
> > @@ -295,7 +295,7 @@ static struct platform_device omap_wdt_device = {
> >  static int __init omap_init_wdt(void)
> >  {
> >  	if (!cpu_is_omap16xx())
> > -		return;
> > +		return -ENODEV;
> >  
> >  	platform_device_register(&omap_wdt_device);
> >  	return 0;
> It's unrelated to this patch, but using
> 
> 	return platform_device_register(&omap_wdt_device);
> 
> would be a bit cleaner.

Felipe, care to update this one?

Tony
