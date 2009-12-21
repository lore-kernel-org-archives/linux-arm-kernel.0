From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 21 Dec 2009 12:47:56 +0000
Subject: [PATCH] armv6: invalidate cache on
	DMA_FROM_DEVICE/DMA_BIDIRECTIONAL
In-Reply-To: <20091221124438.GC11669@n2100.arm.linux.org.uk>
References: <1261357222-18470-1-git-send-email-jamie.iles@picochip.com>
	<1261386497-2924-1-git-send-email-jamie.iles@picochip.com>
	<1261386497-2924-2-git-send-email-jamie.iles@picochip.com>
	<20091221124438.GC11669@n2100.arm.linux.org.uk>
Message-ID: <20091221124756.GD4097@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 21, 2009 at 12:44:38PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 21, 2009 at 09:08:17AM +0000, Jamie Iles wrote:
> > Some ARMv6 cores will use speculative prefetching. This can be a problem
> > when devices DMA to memory and the core prefetches data before the
> > device has written it. This can result in stale data being stored in the
> > cache. The DMA API will request the invalidation but this is currently a
> > no-op on v6. Use the same dma_unmap_area implementation as for v7.
> > 
> > Additionally, simplify v6_dma_map_area() so that we clean the cache lines
> > for DMA_TO_DEVICE and DMA_FROM_DEVICE but don't do any invalidation. This
> > will be done when we unmap.
> 
> I was thinking about doing this for ARMv6, but I thought the concensus
> was that ARMv6 didn't have speculative prefetching.
I couldn't find the words in the TRM that categorically stated it either way,
but on the 1176JZ-S platform that I'm using this definitely needs to be done.
> 
> Nevertheless, the patch is fine, can I just combine it with the other
> DMA patches - it is after all just a copy of the ARMv7 code.
Sure, fine with me.

Jamie
