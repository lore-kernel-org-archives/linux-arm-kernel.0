From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Apr 2011 13:21:16 +0200
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1304036754.2513.201.camel@pasglop>
References: <201104212129.17013.arnd@arndb.de>
	<20110428131531.GK17290@n2100.arm.linux.org.uk>
	<1304036754.2513.201.camel@pasglop>
Message-ID: <201104291321.16191.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 April 2011, Benjamin Herrenschmidt wrote:
> 
> > However, dma_alloc_coherent() memory can't be used with the dma_sync_*
> > API as its return address (unlike other architectures) is not in the
> > kernel direct mapped memory range.
> 
> Well, on non-coherent architectures, dma_sync_* are cache flushes, I
> don't see the point of doing those on a non-cachable mapping anyways.
> 
The point was that you cannot do

#define dma_alloc_coherent dma_alloc_noncoherent

on ARM, as some other architectures do.

	Arnd
