From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Jul 2011 15:58:56 +0100
Subject: [PATCH 2/6] ARM: move ARCH_HAS_DMA_SET_COHERENT_MASK into memory.h
In-Reply-To: <4E1866A2.9040407@gmail.com>
References: <1309366019-24379-1-git-send-email-robherring2@gmail.com>
	<1309366019-24379-3-git-send-email-robherring2@gmail.com>
	<4E1866A2.9040407@gmail.com>
Message-ID: <20110709145856.GM4812@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 09, 2011 at 09:33:06AM -0500, Rob Herring wrote:
> I noticed this is going to have conflicts with your ARM_DMA_ZONE_SIZE
> series. Can you add this into your series? This still presents another
> issue to solve for single kernel binary, but hopefully the dma mapping
> work will help.

That's a different problem - its about limiting the maximum DMA mask
which can be set, so that memory is sourced from the right place
even for drivers which use 32-bit masks.

It's needed to ensure that dma_set_coherent_mask() can be overridden.
One solution to it would be to ensure that we always define
ARCH_HAS_DMA_SET_COHERENT_MASK, and handle the differences internally,
which is something I've been thinking about adding to my DMA bounce
series of patches.
