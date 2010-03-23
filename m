From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 23 Mar 2010 21:33:45 +0000
Subject: [PATCH 1/5] ARM: Use lazy cache flushing on ARMv7 SMP systems
In-Reply-To: <20100322151939.6353.7646.stgit@e102109-lin.cambridge.arm.com>
References: <20100322151729.6353.79984.stgit@e102109-lin.cambridge.arm.com>
	<20100322151939.6353.7646.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20100323213345.GH19572@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 22, 2010 at 03:19:39PM +0000, Catalin Marinas wrote:
> ARMv7 processors like Cortex-A9 broadcast the cache maintenance
> operations in hardware. This patch allows the
> flush_dcache_page/update_mmu_cache pair to work in lazy flushing mode
> similar to the UP case.

Didn't Ben point out that there's a race with the lazy dcache flushing
on SMP platforms?

> The standard ICIALLU and BPIALL operations are not automatically
> broadcast to the other CPUs in an MP system. The patch adds the Inner
> Shareable variants, ICIALLUIS and BPIALLIS, if ARMv7 and SMP.

Jargon overload.  (Just because it's in a specification does not mean
the names are a good idea.)

In any case, this should probably be two separate patches.
