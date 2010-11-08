From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Nov 2010 10:31:18 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101108102525.GB14138@n2100.arm.linux.org.uk>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<20101108101452.GA14138@n2100.arm.linux.org.uk>
	<1289211651.3541.0.camel@e102109-lin.cambridge.arm.com>
	<20101108102525.GB14138@n2100.arm.linux.org.uk>
Message-ID: <1289212278.3541.2.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-11-08 at 10:25 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 08, 2010 at 10:20:51AM +0000, Catalin Marinas wrote:
> > On Mon, 2010-11-08 at 10:14 +0000, Russell King - ARM Linux wrote:
> > > On Mon, Nov 08, 2010 at 09:48:13AM +0000, Catalin Marinas wrote:
> > > > Russell had a better idea for handling this, not sure whether it went
> > > > into -next. It was basically adding -march=armv7-a to
> > > > CFLAGS_swp_emulate.o in arch/arm/kernel/Makefile since we can't trigger
> > > > an undef fault for SWP on ARMv6 anyway.
> > >
> > > It's probably not a good idea to override the compiler architecture,
> > > but just allow the assembler to accept the instruction.  -Wa,-march=armv7-a
> > > should be good enough.
> >
> > Yes, even better via AFLAGS.
> 
> Not by AFLAGS unless you want to rewrite swp_emulate entirely in assembler!
> AFLAGS is used for .S -> .o.  CFLAGS is used for .c -> .o.

No, what I meant was via -Wa,

> > Do you have a patch already or I should push one?
> 
> I've already fixed it.

Anyway, good that you've fixed it. Thanks.

Catalin
