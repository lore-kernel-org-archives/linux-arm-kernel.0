From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 09:47:11 +0100
Subject: [PATCH 00/10] dmabounce cleanups
Message-ID: <20110704084711.GN21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series cleans up the DMA bounce code with the following in mind:

1. Fix the map_single failure case to return the correct dma_addr_t
   indicating failure.
2. Allow __dma_map_page() to work for non-bounced highmem pages.
3. Get rid of the global dma_needs_bounce function, passing it at
   registration time.

Without this patch set, enabling DMA bounce support causes the DMA API to
fail all attempts to map highmem pages whether or not they will be using
the DMA bounce API.  We address that in this patch set, but DMA bounce
itself will still not permit highmem pages.

The first patch in the series fixing the failure return value will be
queued for -rc and stable trees.
