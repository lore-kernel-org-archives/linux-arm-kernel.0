From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Jan 2010 17:47:51 +0000
Subject: [PATCH] armv6: invalidate cache
	onDMA_FROM_DEVICE/DMA_BIDIRECTIONAL
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203A85EB687@dlee02.ent.ti.com>
References: <13B9B4C6EF24D648824FF11BE896716203A85EB687@dlee02.ent.ti.com>
Message-ID: <1263491271.3964.82.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-08 at 23:06 +0000, Woodruff, Richard wrote:
> 
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-arm-kernel-
> > bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux
> > Sent: Monday, December 21, 2009 6:45 AM
> 
> > I was thinking about doing this for ARMv6, but I thought the concensus
> > was that ARMv6 didn't have speculative prefetching.
> 
> If you bolt on a unified L2 cache won't normal branch prediction
> result in some possible erroneous data in L2 cache range (assume mmu
> execution flag is set I suppose)?

I think that's possible, in which case we should treat ARMv6 in a
similar way to ARMv7, in case we have an external L2 cache.

-- 
Catalin
