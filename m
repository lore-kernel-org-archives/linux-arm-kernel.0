From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Mar 2010 09:51:13 +0000
Subject: [PATCH 1/5] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <20100323213345.GH19572@n2100.arm.linux.org.uk>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151939.6353.7646.stgit@e102109-lin.cambridge.arm.com>
	<20100323213345.GH19572@n2100.arm.linux.org.uk>
Message-ID: <1269424273.29073.16.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-03-23 at 21:33 +0000, Russell King - ARM Linux wrote:
> On Mon, Mar 22, 2010 at 03:19:39PM +0000, Catalin Marinas wrote:
> > ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> > operations in hardware. This patch allows the
> > flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
> > similar to the UP case.
> 
> Didn't Ben point out that there's a race with the lazy dcache flushing
> on SMP platforms?

Yes, there is a slight risk of getting this race. I started working on a
patch to move the cache flushing to set_pte_at (and together with the
PG_dcache_clean bit) but I don't think I'll finish it in time (I'm on
holiday between 1-19 April). That's if we decide to go this route, the
other thread (USB mass storage ...) seems to have slowed down.

So I think it's better to wait with this patch for now and maybe post a
full series addressing the issues above sometime next month.

-- 
Catalin
