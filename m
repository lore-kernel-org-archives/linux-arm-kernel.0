From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 30 Apr 2015 15:54:30 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <55423317.7000401@topic.nl>
References: <5538DD02.6050401@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <55423317.7000401@topic.nl>
Message-ID: <2309938.la6bU0Xy8o@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 30 April 2015 15:50:15 Mike Looijmans wrote:
> 
> Just to give you a status update, I tried that too (by adding a 
> dma_mmap_coherent variant that omits the "prot" change, and some printks to 
> verify that it actually does as expected).
> 
> Current status is that the ACP behaves exactly like the HP port, which it 
> should not do. If I send data from logic via the ACP port through the L2 
> cache, using a version of dma_sync that just invalidates the cache could 
> (should?) result in data corruption. Instead, the data gets corrupted only if 
> you do not invalidate the line. This is what the (non-coherent) HP port 
> behaves like, as it writes directly to DDR.
> 
> Currently I'm assuming that the tools did something wrong in the bitstream, 
> for example, wiring the "AWCACHE" and similar signals on the ACP to logic "0" 
> instead of "1" while claiming to have wired them to "1" in the UI. A bug like 
> that would also explain the behaviour I'm seeing now.
> 
> I'll let you know once I find out more.
> 
> 

Ok, maybe you have to configure the SCU to include the ACP in the
cache coherency? That might not be done by default. I don't really
know anything about the SCU or the ACP, so I'm just taking wild
guesses here.

	Arnd
