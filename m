From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 20:30:46 +0000
Subject: linux-next: omap2plus_defconfig not building
In-Reply-To: <20101223195503.GN7771@atomide.com>
References: <4CBD707F.6050204@ti.com>
	<1287488255.18646.110.camel@e102109-lin.cambridge.arm.com>
	<eace9c309e371630528bc9f8fa208705@mail.gmail.com>
	<1289209693.3538.5.camel@e102109-lin.cambridge.arm.com>
	<20101223195503.GN7771@atomide.com>
Message-ID: <20101223203046.GR3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 11:55:03AM -0800, Tony Lindgren wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [101108 01:38]:
> > On Mon, 2010-11-08 at 06:05 +0000, Anand Gadiyar wrote:
> > > I can't find this patch in linux-next. Hope we haven't missed it.
> > > Tony acked this btw.
> > > 
> > > Strangely, the omap2plus_defconfig in v2.6.37-rc1 no longer gets
> > > CONFIG_SWP_EMULATE enabled even without this patch - I can't figure
> > > out why.

That'll be because swap emulation isn't in v2.6.37-rc1.  It's queued
for 2.6.38's merge window.

> > Russell had a better idea for handling this, not sure whether it went
> > into -next. It was basically adding -march=armv7-a to
> > CFLAGS_swp_emulate.o in arch/arm/kernel/Makefile since we can't trigger
> > an undef fault for SWP on ARMv6 anyway.
> > 
> > If it's not in yet, I can submit a patch.

It's also queued for 2.6.38, but there is an issue with the latest gcc
stuffing a .armv7 directive (or whatever) at the beginning of its
output, thereby overriding the -Wa,-march=armv7-a on the command line.
I think someone's looking at fixing GCC.

This stuff _is_ in linux-next, and has been in linux-next for ages.
