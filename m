From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 7 Jun 2011 09:54:46 +0100
Subject: [PATCH] ARM: fix ioremap to allow mapping some specific RAM areas
In-Reply-To: <003c01cc24ef$151827b0$3f487710$%szyprowski@samsung.com>
References: <1307430745-17329-1-git-send-email-m.szyprowski@samsung.com>
	<20110607080541.GA20929@n2100.arm.linux.org.uk>
	<003c01cc24ef$151827b0$3f487710$%szyprowski@samsung.com>
Message-ID: <20110607085446.GC20929@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2011 at 10:44:15AM +0200, Marek Szyprowski wrote:
> On Tuesday, June 07, 2011 10:06 AM Russell King - ARM Linux wrote:
> > NAK.  pfn_valid is already defined like this:
> > 
> > int pfn_valid(unsigned long pfn)
> > {
> >         return memblock_is_memory(pfn << PAGE_SHIFT);
> > }
> > 
> > provided you enable ARCH_HAS_HOLES_MEMORYMODEL, which you must do if
> > you're punching holes in the memory map.
> 
> Ok, I see the point in ARCH_HAS_HOLES_MEMORYMODEL, but it doesn't solve my
> problem. In case of Samsung Exynos4 and S5PV210 platforms we use SPARSEMEM,
> but the above definition of pfn_valid() function is correct only if SPARSEMEM
> is not enabled.

Sparsemem has been fixed recently (during the merge window) so that this
is now correct.
