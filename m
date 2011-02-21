From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 21 Feb 2011 09:36:41 +0100
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <c170bbf2-ac0a-4c55-b2a7-0215c7a79635@VA3EHSMHS032.ehs.local>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<201102202237.47327.arnd@arndb.de>
	<c170bbf2-ac0a-4c55-b2a7-0215c7a79635@VA3EHSMHS032.ehs.local>
Message-ID: <201102210936.42098.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 21 February 2011, John Linn wrote:
> > > diff --git a/arch/arm/mach-xilinx/include/mach/timex.h
> > b/arch/arm/mach-xilinx/include/mach/timex.h
> > > new file mode 100644
> > > index 0000000..4ebc0a6
> > > --- /dev/null
> > > +++ b/arch/arm/mach-xilinx/include/mach/timex.h
> > > +#ifndef __MACH_TIMEX_H__
> > > +#define __MACH_TIMEX_H__
> > > +
> > > +#define PERIPHERAL_CLOCK_RATE  2500000
> > > +
> > > +#define CLOCK_TICK_RATE        (PERIPHERAL_CLOCK_RATE / 32)
> > > +
> > > +#endif
> > 
> > I thought we were at the point where CLOCK_TICK_RATE is no longer
> used.
> 
> The timer code in these patches is using it, no other comments on it so
> far.
> 
> > Did the patches not make it in yet?
> > 
> 
> I haven't heard they made them in yet, just waiting and hoping for an
> ack.

I meant the patches removing CLOCK_TICK_RATE from common code, not your
patches, sorry for being vague.

It would be better if you could avoid introducing new uses of
CLOCK_TICK_RATE, because that will have to be removed before we can 
move to a real multi-platform kernel. For instance, you can put
PERIPHERAL_CLOCK_RATE in a hardware specific header and put a bogus
definition for CLOCK_TICK_RATE into timex.h

	Arnd
