From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Jun 2012 14:56:56 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <Pine.LNX.4.64.1206211250190.3513@axis700.grange>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206151127.24386.arnd@arndb.de>
 <Pine.LNX.4.64.1206211250190.3513@axis700.grange>
Message-ID: <201206211456.56933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 June 2012, Guennadi Liakhovetski wrote:
> Indeed, this solution should be good enough, thanks! I'm not sure, whether 
> making this multiplexing available requires any additional code to the 
> generic DMA DT binding implementation. If it does - please, let's make 
> this a part of the implementation.

It depends how the dma engine gets represented in Linux then: Either
we make the common dmaengine code handle multiple dma-engines with the
same of_node pointer, or you make the driver register a single dma-engine
to Linux that is backed by the three physical devices but just one
of_node pointer. I think either way will work, and someone has to
try it to determine which one is simpler.

> It is also important to provide a flexible multiple channel per device 
> configuration support to let slave drivers distinguish between different 
> DMA channels, that they get back from the API. But I think this is a part 
> of the current proposal and is being taken care of.

Yes, it is.

	Arnd
