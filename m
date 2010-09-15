From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 15 Sep 2010 09:28:50 +0200
Subject: [PATCH 4/5] DMA: Add functions to preallocate DMA memory dor
	devices
In-Reply-To: <20100902105055.GS26319@n2100.arm.linux.org.uk>
References: <Pine.LNX.4.64.1008191623580.26145@axis700.grange>
	<Pine.LNX.4.64.1008191636590.26145@axis700.grange>
	<20100902105055.GS26319@n2100.arm.linux.org.uk>
Message-ID: <20100915072850.GB17325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Sep 02, 2010 at 11:50:55AM +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 19, 2010 at 04:40:22PM +0200, Guennadi Liakhovetski wrote:
> > Currently dma_declare_coherent_memory() and dma_release_declared_memory() are
> > provided to assign DMA memory to a device and to release it. These functions
> > can be use with device local memory, like on-chip SRAM. However, they are
> > unsuitable for assigning of generic system RAM to devices, because such system
> > memory should not be ioremapped, and ioremap() is used internally in the former
> > of these functions to map the memory.
> > 
> > This patch solves this problem by adding two more functions:
> > dma_preallocate_coherent_memory() and dma_release_preallocated_memory(), which
> > allocate DMA coherent memory and assign it to the device, and release it back
> > respectively.
> 
> This looks like a much saner interface for pre-allocating DMA memory from
> system memory, rather than trying to use dma_declare_coherent_memory().
> 
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

If this series isn't acceptable for the DMA people, I suggest to add it
locally for ARM if no other solution is found before .36 is released.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
