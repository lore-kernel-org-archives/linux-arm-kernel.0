From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 25 Nov 2009 12:19:42 +0000
Subject: [PATCH v2 07/17] ARM: dma-mapping: no need to clean
	overlapping cache lines on invalidate
In-Reply-To: <E1NCZ7s-0002A3-0R@rmk-PC.arm.linux.org.uk>
References: <E1NBYEI-0005lA-8a@rmk-PC.arm.linux.org.uk>
	<E1NCZ7s-0002A3-0R@rmk-PC.arm.linux.org.uk>
Message-ID: <1259151582.30270.61.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-11-23 at 13:38 +0000, Russell King - ARM Linux wrote:
> Since we now clean the DMA buffers on map, 

Is this still valid with the latest patch you sent?

> there's no need to clean
> overlapping cache lines on invalidation anymore.  (Note: the DMA API
> prohibits other data sharing the same cache line as a DMA buffer
> anyway.)

Why was this cleaning ever needed if the DMA API prohibits cache line
sharing?

Even if we do cleaning on map, having shared cache lines is broken since
you may do an invalidate on unmap but the shared cache line may have
been dirtied.

-- 
Catalin
