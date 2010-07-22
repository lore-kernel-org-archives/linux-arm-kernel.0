From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 22 Jul 2010 12:11:29 +0100
Subject: [PATCH] ARM: Versatile Express: Add default memory layout
In-Reply-To: <20100722105729.GK31293@n2100.arm.linux.org.uk>
References: <20100721165509.26047.70564.stgit@e102109-lin.cambridge.arm.com>
	<20100722103038.GE31293@n2100.arm.linux.org.uk>
	<1279796069.9564.2.camel@e102109-lin.cambridge.arm.com>
	<20100722105729.GK31293@n2100.arm.linux.org.uk>
Message-ID: <1279797089.9564.21.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-07-22 at 11:57 +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 22, 2010 at 11:54:29AM +0100, Catalin Marinas wrote:
> > On Thu, 2010-07-22 at 11:30 +0100, Russell King - ARM Linux wrote:
> > > On Wed, Jul 21, 2010 at 05:55:09PM +0100, Catalin Marinas wrote:
> > > > Since this platform is known to have 1GB of RAM at 0x60000000, add a
> > > > .fixup function to set the defaults in case no "mem=" option is passed
> > > > on the kernel command line.
> > >
> > > And the reason why uboot can't pass the RAM information to the kernel
> > > is...
> >
> > It needs implementing, or ask the user to pass it on the kernel command
> > line. For the latter, I think it would be nicer if the kernel has some
> > sane defaults.
> 
> The kernel does have some sane _safe_ defaults - it assumes that there's
> at least 16M of RAM.

That's only during the initial MMU setup. Afterwards it cannot allocate
any memory without a proper mem= parameter or ATAG.

> > But anyway I'm proposing this patch for similarities to mach-realview.
> 
> I don't think that's a good enough justification.  We have the fixup for
> realview because of the dual RAM mappings in physical space, and the
> boot loader doesn't know which one we're using.  That problem is unique
> to the Realview platforms, and doesn't exist on any of the other ARM
> development platforms.

I think this goes down to personal preference - pushing more
configuration towards the bootloader or having some correct defaults in
the kernel. If you prefer the former, that's fine as well. At some point
I hope the device tree would solve all this anyway.

-- 
Catalin
