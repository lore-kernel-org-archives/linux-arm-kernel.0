From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Apr 2015 14:32 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <5538DD02.6050401@topic.nl>
References: <5538DD02.6050401@topic.nl>
Message-ID: <2757951.K585xX1rYN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 April 2015 13:52:34 Mike Looijmans wrote:
> Can anyone here offer some advise on this?
> 

The problem you are experiencing is a direct result of using hardware
without cache-coherency from user space. There is no software workaround
for this: If you want data to be cacheable *and* avoid doing manual cache
flushes each time data is passed between user space and hardware, you have
to use hardware that is cache-coherent.

You mentioned that you are using 'Zynq', which supports cache-coherent
DMA using the 'accelerator coherency port'. If you are able to connect
your device to that port, it should work, otherwise you should consider
using a different platform.

	Arnd
