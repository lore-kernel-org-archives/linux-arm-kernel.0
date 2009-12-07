From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2009 19:35:48 +0000
Subject: non barrier versions of dma_map functions
In-Reply-To: <7f6a66b765002fcc815937b5d8d085cf.squirrel@www.codeaurora.org>
References: <7f6a66b765002fcc815937b5d8d085cf.squirrel@www.codeaurora.org>
Message-ID: <20091207193548.GG26821@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2009 at 11:37:21AM -0800, adharmap at codeaurora.org wrote:
> We have a situation where we need to dma map multiple cached buffers for a
> single dma transaction.
> 
> The current DMA api suggests the use of dma_map_single for cache
> consistency. On ARMv7 it performs the necessary cache-operations and calls
> data sync barrier instruction (DSB). In our case we would be executing
> multiple DSB instruction before starting the dma operation - we need
> memory to be consistent only after we map the last buffer.

Is it a problem and do you have numbers to illustrate why it is a
problem, or is this just theory?

I suspect that the DSB doesn't figure in the bigger scheme of things
(such as running the cache maintainence operations.)  Moreover, there's
bigger issues (such as the DMA cache maintainence on ARMv7 actually
*being* correct - by invalidating after the DMA has completed) to be
getting on with at the moment that things as you're suggesting aren't
worth worrying about.
