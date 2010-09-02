From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 11:50:55 +0100
Subject: [PATCH 4/5] DMA: Add functions to preallocate DMA memory dor
	devices
In-Reply-To: <Pine.LNX.4.64.1008191636590.26145@axis700.grange>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191636590.26145@axis700.grange>
Message-ID: <20100902105055.GS26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 19, 2010 at 04:40:22PM +0200, Guennadi Liakhovetski wrote:
> Currently dma_declare_coherent_memory() and dma_release_declared_memory() are
> provided to assign DMA memory to a device and to release it. These functions
> can be use with device local memory, like on-chip SRAM. However, they are
> unsuitable for assigning of generic system RAM to devices, because such system
> memory should not be ioremapped, and ioremap() is used internally in the former
> of these functions to map the memory.
> 
> This patch solves this problem by adding two more functions:
> dma_preallocate_coherent_memory() and dma_release_preallocated_memory(), which
> allocate DMA coherent memory and assign it to the device, and release it back
> respectively.

This looks like a much saner interface for pre-allocating DMA memory from
system memory, rather than trying to use dma_declare_coherent_memory().

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
