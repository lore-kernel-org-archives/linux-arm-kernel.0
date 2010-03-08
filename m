From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Mar 2010 16:31:25 +0000
Subject: [PATCH 4/6] ARMv7: Use lazy cache flushing if hardware
	broadcastscache operations
In-Reply-To: <1268065501.25012.28.camel@e102109-lin.cambridge.arm.com>
References: <20091207141339.30429.28247.stgit@pc1117.cambridge.arm.com>
	<1268065501.25012.28.camel@e102109-lin.cambridge.arm.com>
Message-ID: <20100308163125.GA13856@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 08, 2010 at 04:25:01PM +0000, Catalin Marinas wrote:
> Hi Russell,
> 
> On Mon, 2009-12-07 at 14:13 +0000, Catalin Marinas wrote:
> > ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> > operations in hardware. The patch adds the CPU ID checks for such
> > feature and allows the flush_dcache_page/update_mmu_cache pair to work
> > in lazy flushing mode similar to the UP case.
> 
> It looks like I haven't got a final ok from you on this patch (I had the
> impression that it's in the patch system already but rebased my patches
> and found that it's not in mainline).

It needs to be updated - we have a cache_ops_need_broadcast() in
smp_plat.h now for the ptrace issues.
