From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Apr 2011 16:26:43 +0100
Subject: [RFC PATCH] Consolidate SRAM support
In-Reply-To: <201104151640.01040.arnd@arndb.de>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<4DA84AAB.60601@gmail.com> <201104151640.01040.arnd@arndb.de>
Message-ID: <20110415152643.GC4423@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2011 at 04:40:00PM +0200, Arnd Bergmann wrote:
> On Friday 15 April 2011 15:39:55 Rob Herring wrote:
> 
> > On 04/15/2011 08:06 AM, Russell King - ARM Linux wrote:
> > > This is work in progress.
> > >
> > > We have two SoCs using SRAM, both with their own allocation systems,
> > > and both with their own ways of copying functions into the SRAM.
> > 
> > It's more than that. Several i.MX chips use plat-mxc/iram_alloc.c.
> 
> There are also non-ARM systems doing something like that,
> arch/blackfin/mm/sram-alloc.c comes to mind. On powerpc, the
> ppc7410 also has this feature in hardware, but I believe it was
> never supported in mainline Linux.

Yes, but there's some horrible bits out there.  PPC is one of them
which looks like it doesn't lend itself to consolidating with this
kind of implementation.

> How about putting sram-pool.c into the top-level mm/ directory
> and sram-pool.h into include/linux? They seem to be completely
> generic to me, aside from the dependency on asm/fncpy.h which
> should probably remain arch specific.

I've thought about lib - but first lets see whether other architectures
want to use it first.  I've asked the sh folk off-list about this and
waiting for a reply.

Blackfin and PPC look horrible to sort out though, so they can come at
a later date if they so wish.
