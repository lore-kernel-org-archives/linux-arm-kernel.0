From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 07 Jun 2011 12:49:36 +0200
Subject: [PATCH] ARM: fix ioremap to allow mapping some specific RAM	areas
In-Reply-To: <20110607085446.GC20929@n2100.arm.linux.org.uk>
References: <1307430745-17329-1-git-send-email-m.szyprowski@samsung.com>
	<20110607080541.GA20929@n2100.arm.linux.org.uk>
	<003c01cc24ef$151827b0$3f487710$%szyprowski@samsung.com>
	<20110607085446.GC20929@n2100.arm.linux.org.uk>
Message-ID: <004001cc2500$97d4dfc0$c77e9f40$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tuesday, June 07, 2011 10:55 AM Russell King - ARM Linux wrote:

> On Tue, Jun 07, 2011 at 10:44:15AM +0200, Marek Szyprowski wrote:
> > On Tuesday, June 07, 2011 10:06 AM Russell King - ARM Linux wrote:
> > > NAK.  pfn_valid is already defined like this:
> > >
> > > int pfn_valid(unsigned long pfn)
> > > {
> > >         return memblock_is_memory(pfn << PAGE_SHIFT);
> > > }
> > >
> > > provided you enable ARCH_HAS_HOLES_MEMORYMODEL, which you must do if
> > > you're punching holes in the memory map.
> >
> > Ok, I see the point in ARCH_HAS_HOLES_MEMORYMODEL, but it doesn't solve
> my
> > problem. In case of Samsung Exynos4 and S5PV210 platforms we use
> SPARSEMEM,
> > but the above definition of pfn_valid() function is correct only if
> SPARSEMEM
> > is not enabled.
> 
> Sparsemem has been fixed recently (during the merge window) so that this
> is now correct.

OK, thanks for help.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
