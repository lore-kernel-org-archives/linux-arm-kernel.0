From: John.Linn@xilinx.com (John Linn)
Date: Mon, 21 Feb 2011 07:36:56 -0700
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <201102210936.42098.arnd@arndb.de>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<201102202237.47327.arnd@arndb.de>
	<c170bbf2-ac0a-4c55-b2a7-0215c7a79635@VA3EHSMHS032.ehs.local>
	<201102210936.42098.arnd@arndb.de>
Message-ID: <c3cdf33d-2163-4417-bc64-7637f5c211e0@VA3EHSMHS021.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Monday, February 21, 2011 1:37 AM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; catalin.marinas at arm.com; glikely at secretlab.ca;
> jamie at jamieiles.com
> Subject: Re: [PATCH V4 3/4] ARM: Xilinx: base header files and
assembly
> macros
> 
> On Monday 21 February 2011, John Linn wrote:
> > > > diff --git a/arch/arm/mach-xilinx/include/mach/timex.h
> > > b/arch/arm/mach-xilinx/include/mach/timex.h
> > > > new file mode 100644
> > > > index 0000000..4ebc0a6
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-xilinx/include/mach/timex.h
> > > > +#ifndef __MACH_TIMEX_H__
> > > > +#define __MACH_TIMEX_H__
> > > > +
> > > > +#define PERIPHERAL_CLOCK_RATE  2500000
> > > > +
> > > > +#define CLOCK_TICK_RATE        (PERIPHERAL_CLOCK_RATE / 32)
> > > > +
> > > > +#endif
> > >
> > > I thought we were at the point where CLOCK_TICK_RATE is no longer
> > used.
> >
> > The timer code in these patches is using it, no other comments on it
> so
> > far.
> >
> > > Did the patches not make it in yet?
> > >
> >
> > I haven't heard they made them in yet, just waiting and hoping for
an
> > ack.
> 
> I meant the patches removing CLOCK_TICK_RATE from common code, not
your
> patches, sorry for being vague.

Ahh... understand.  No problem, wishful thinking on my part :)

> 
> It would be better if you could avoid introducing new uses of
> CLOCK_TICK_RATE, because that will have to be removed before we can
> move to a real multi-platform kernel. For instance, you can put
> PERIPHERAL_CLOCK_RATE in a hardware specific header and put a bogus
> definition for CLOCK_TICK_RATE into timex.h

Hi Arnd,

I can remove the use of it from my timer code, but I still see
CLOCK_TICK_RATE 
being used in linux/jiffies.h.

I tried removing it and got build errors.  Am I missing something there?

Thanks,
John

> 
> 	Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
