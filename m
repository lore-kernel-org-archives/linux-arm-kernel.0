From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2009 12:09:12 +0000
Subject: [PATCH 7/7] ARM: dma-mapping: no need to clean overlapping
	cachelines on invalidate
In-Reply-To: <E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
References: <E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
Message-ID: <1258978152.8088.19.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-11-20 at 18:07 +0000, Russell King - ARM Linux wrote:
> Since we now clean the DMA buffers on map, there's no need to clean
> overlapping cache lines on invalidation anymore.  (Note: the DMA API
> prohibits other data sharing the same cache line as a DMA buffer
> anyway.)

If patch 6/7 cleans before the transfer (I made a comment on performance
but haven't run any benchmarks), it makes sense to have this
simplification.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
