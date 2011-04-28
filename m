From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Apr 2011 16:39:59 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <20110428143440.GP17290@n2100.arm.linux.org.uk>
References: <201104212129.17013.arnd@arndb.de>
	<201104281629.52863.arnd@arndb.de>
	<20110428143440.GP17290@n2100.arm.linux.org.uk>
Message-ID: <201104281640.00107.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 28 April 2011, Russell King - ARM Linux wrote:
> On Thu, Apr 28, 2011 at 04:29:52PM +0200, Arnd Bergmann wrote:
> > Given that people still want to have an interface that does what I
> > though this one did, I guess we have two options:
> > 
> > * Kill off dma_cache_sync and replace it with calls to dma_sync_*
> >   so we can start using dma_alloc_noncoherent on ARM
> 
> I don't think this is an option as dma_sync_*() is part of the streaming
> DMA mapping API (dma_map_*) which participates in the idea of buffer
> ownership, which the noncoherent API doesn't appear to.

I thought the problem was in fact that the noncoherent API cannot be
implemented on architectures like ARM specifically because there is
no concept of buffer ownership. The obvious way to fix that would
be to redefine the API. What am I missing?

	Arnd
