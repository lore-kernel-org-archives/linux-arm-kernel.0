From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Mon, 24 Aug 2009 12:57:39 +0200
Subject: i.MX35 Kernel without ARM EABI support  cannot execute init
In-Reply-To: <1251111204.4782.138.camel@wks02-lin.nanotronic.local>
References: <1250865435.17931.20.camel@wks02-lin.nanotronic.local>
	<20090824101739.GH29655@pengutronix.de>
	<1251111204.4782.138.camel@wks02-lin.nanotronic.local>
Message-ID: <20090824105739.GN29655@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2009 at 12:53:24PM +0200, hoefle marco wrote:
> > On Fri, Aug 21, 2009 at 04:37:15PM +0200, hoefle marco wrote:
> > > right now we have two ARM boards and two embedded linux
> > > distributions (Emdebian and OSELAS). The CPUs are PXA270 and
> > > Freescale i.MX35. The aim is to have emdebian on both boards.
> >
> > Why? :-)
>
> Because the aim is to have one linux distribution for all projects
> (independent from the CPU). Also the emdebian package administration
> is quite handy and identical to the "PC Debian".

"one fits it all" is often the opposite of "optimized" for an embedded
device". But that's another discussion :-)

> > > Has anybody an idea why this is not working?
> >
> > Are you sure your toolchains generate the right code for your CPUs?
> > If you want to have root fs for both, PXA270 and i.MX35, you
> > probably need an ARMv4 Toolchain. Unfortunately, your
> > "arm-linux-gnu-gcc" compiler name doesn't suggest anything about
> > what code this compiler generates.
>
> If I compile the kernel with the debian "arm-linux-gnu-gcc" compiler
> and the kernel has enabled ARM EABI the OSELAS root filesystem still
> boots.
>
> The emdebian Busybox was also compiled with that compiler. I don't see
> a reason why this Kernel panic occurs.

Is there a reason why you are trying a "mixed" system at all? Getting
such problems right is often a matter of using tools in a consistent
way.

Does a simple boot with "init=/bin/sh" work? If not, you might want to
try a statically linked shell for that; it gives often more hints for
debugging when you have access to Linux.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
