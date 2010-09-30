From: tony@atomide.com (Tony Lindgren)
Date: Thu, 30 Sep 2010 09:51:04 -0700
Subject: [PATCH] OMAP2PLUS: WDT: Fix: Disable WDT after reset during init
In-Reply-To: <alpine.DEB.2.00.1009301040390.5439@utopia.booyaka.com>
References: <1285834270-32766-1-git-send-email-charu@ti.com>
	<4CA45341.3080300@ti.com> <87vd5njpyq.fsf@deeprootsystems.com>
	<4CA49ADE.6080202@ti.com> <20100930150713.GG3117@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813E@dbde02.ent.ti.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030CCF813F@dbde02.ent.ti.com>
	<alpine.DEB.2.00.1009301040390.5439@utopia.booyaka.com>
Message-ID: <20100930165104.GJ3117@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [100930 09:34]:
> Hello Charu,
> 
> On Thu, 30 Sep 2010, Varadarajan, Charulatha wrote:
> 
> > > > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > > > index 8e2f0aa..9f44fc6 100644
> > > > --- a/arch/arm/mach-omap2/devices.c
> > > > +++ b/arch/arm/mach-omap2/devices.c
> > > > +
> > > > +static void __init omap_disable_wdt(void)
> > > > +{
> > > > +	if (cpu_class_is_omap2())
> > > 
> > > This code is already in mach-omap2/devices.c, so that test should be 
> > > useless.
> > 
> > I do not see a cpu_class_is_omap2() check in omap2_init_devices(). Please
> > point out where this check is done while/before calling omap_disable_wdt()?
> 
> It's implicit, due to the directory arch/arm/mach-omap2/ -- code in that 
> directory is only built for OMAP2+ systems -- and right now there are no 
> plans for OMAP1+ multi-arch booting.  So it's safe to assume that any code 
> in arch/arm/mach-omap2 will only run on OMAP2+ boards.

That might change pretty fast though. There are already experimental patches
to build in multiple ARM archs into a single kernel binary.

So we should already have these checks in place to avoid the initcalls running
on other ARM archs.

Regards,

Tony
