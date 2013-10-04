From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 4 Oct 2013 09:14:40 -0400 (EDT)
Subject: [PATCH v3 6/6] ARM: mm: Change the order of TLB/cache maintenance
 operations.
In-Reply-To: <20131004084643.GJ12758@n2100.arm.linux.org.uk>
References: <1380835081-12129-1-git-send-email-santosh.shilimkar@ti.com>
 <1380835081-12129-7-git-send-email-santosh.shilimkar@ti.com>
 <20131004084643.GJ12758@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.03.1310040911240.3023@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 4 Oct 2013, Russell King - ARM Linux wrote:

> On Thu, Oct 03, 2013 at 05:18:00PM -0400, Santosh Shilimkar wrote:
> > From: Sricharan R <r.sricharan@ti.com>
> > 
> > As per the arm ARMv7 manual, the sequence of TLB maintenance
> > operations after making changes to the translation table is
> > to clean the dcache first, then invalidate the TLB. With
> > the current sequence we see cache corruption when the
> > flush_cache_all is called after tlb_flush_all.
> 
> This needs testing on ARMv4 CPUs which don't have a way to flush the
> cache except by reading memory - hence they need the new page table
> entries to be visible to the MMU before calling flush_cache_all().

I suspect you might be one of the few individuals still having the 
ability to test new kernels on ARMv4 CPUs.


Nicolas
