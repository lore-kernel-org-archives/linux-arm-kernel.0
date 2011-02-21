From: John.Linn@xilinx.com (John Linn)
Date: Sun, 20 Feb 2011 17:18:14 -0700
Subject: [PATCH V4 3/4] ARM: Xilinx: base header files and assembly macros
In-Reply-To: <201102202237.47327.arnd@arndb.de>
References: <1298052881-14591-1-git-send-email-john.linn@xilinx.com>
	<1298052881-14591-3-git-send-email-john.linn@xilinx.com>
	<42efee69-aca1-446b-a997-f0063e113877@VA3EHSMHS009.ehs.local>
	<201102202237.47327.arnd@arndb.de>
Message-ID: <c170bbf2-ac0a-4c55-b2a7-0215c7a79635@VA3EHSMHS032.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Sunday, February 20, 2011 2:38 PM
> To: John Linn
> Cc: linux-arm-kernel at lists.infradead.org;
linux-kernel at vger.kernel.org;
> linux at arm.linux.org.uk; catalin.marinas at arm.com; glikely at secretlab.ca;
> jamie at jamieiles.com
> Subject: Re: [PATCH V4 3/4] ARM: Xilinx: base header files and
assembly
> macros
> 
> On Friday 18 February 2011, John Linn wrote:
> > +
> > +/* IO address mapping macros, nothing special at this time but
> required */
> > +
> > +#ifdef __ASSEMBLER__
> > +#define IOMEM(x)               (x)
> > +#else
> > +#define IOMEM(x)               ((void __force __iomem *)(x))
> > +#endif
> > +
> > +#define __io(a)                        __typesafe_io(a)
> > +#define __mem_pci(a)           (a)
> 
> Are you planning to support PCI or PCMCIA? If so, the __io definition
> will have to
> change so it points to the PIO register window.

No immediate plans for PCI or PCMCIA.  Makes sense.

> 
> > diff --git a/arch/arm/mach-xilinx/include/mach/timex.h
> b/arch/arm/mach-xilinx/include/mach/timex.h
> > new file mode 100644
> > index 0000000..4ebc0a6
> > --- /dev/null
> > +++ b/arch/arm/mach-xilinx/include/mach/timex.h
> > +#ifndef __MACH_TIMEX_H__
> > +#define __MACH_TIMEX_H__
> > +
> > +#define PERIPHERAL_CLOCK_RATE  2500000
> > +
> > +#define CLOCK_TICK_RATE        (PERIPHERAL_CLOCK_RATE / 32)
> > +
> > +#endif
> 
> I thought we were at the point where CLOCK_TICK_RATE is no longer
used.

The timer code in these patches is using it, no other comments on it so
far.

> Did the patches not make it in yet?
> 

I haven't heard they made them in yet, just waiting and hoping for an
ack.

> The rest looks fine to me.

Great, appreciate the review and your time.

-- John

> 
> 	Arnd


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
