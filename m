From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 15:34:40 +0100
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104281629.52863.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
	<201104281428.56780.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<201104281629.52863.arnd@arndb.de>
Message-ID: <20110428143440.GP17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 04:29:52PM +0200, Arnd Bergmann wrote:
> Given that people still want to have an interface that does what I
> though this one did, I guess we have two options:
> 
> * Kill off dma_cache_sync and replace it with calls to dma_sync_*
>   so we can start using dma_alloc_noncoherent on ARM

I don't think this is an option as dma_sync_*() is part of the streaming
DMA mapping API (dma_map_*) which participates in the idea of buffer
ownership, which the noncoherent API doesn't appear to.
