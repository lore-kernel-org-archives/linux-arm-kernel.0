From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 18 Jan 2011 12:24:08 -0700 (MST)
Subject: State of LDP3430 platform
In-Reply-To: <20110118012541.GN4957@atomide.com>
References: <20101206125526.GC31777@n2100.arm.linux.org.uk>
	<20101206181913.GH8345@atomide.com>
	<alpine.DEB.2.00.1012061125400.13430@utopia.booyaka.com>
	<20101207083720.GB18336@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1012071745120.13430@utopia.booyaka.com>
	<alpine.DEB.2.00.1012072012000.13430@utopia.booyaka.com>
	<20110115000301.GT4957@atomide.com>
	<alpine.DEB.2.00.1101151237240.32245@utopia.booyaka.com>
	<20110115233744.GA18159@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1101152028580.13225@utopia.booyaka.com>
	<20110118012541.GN4957@atomide.com>
Message-ID: <alpine.DEB.2.00.1101181222590.13225@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Jan 2011, Tony Lindgren wrote:

> * Paul Walmsley <paul@pwsan.com> [110115 20:31]:
> > --- a/arch/arm/mach-omap1/time.c
> > +++ b/arch/arm/mach-omap1/time.c
> > @@ -244,6 +244,13 @@ static void __init omap_timer_init(void)
> >  
> >  	omap_init_mpu_timer(rate);
> >  	omap_init_clocksource(rate);
> > +	/*
> > +	 * XXX Since this file seems to deal mostly with the MPU timer,
> > +	 * this doesn't seem like the correct place for the sync timer
> > +	 * clocksource init.
> > +	 */
> > +	if (!cpu_is_omap7xx() && !cpu_is_omap15xx())
> > +		omap_init_clocksource_32k();
> >  }
> >  
> >  struct sys_timer omap_timer = {
> 
> To me it looks like the omap_init_clocksource_32k() call should be
> in arch/arm/mach-omap1/timer32k.c instead.

Just FYI for the lists; Tony and I talked about this off-list; he'll deal 
with this in a subsequent patch to avoid changing the OMAP1 clocksource 
behavior during this patch.


- Paul
