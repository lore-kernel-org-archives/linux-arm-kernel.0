From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 May 2015 16:27:25 +0200
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <554CC5A3.7020607@topic.nl>
References: <5538DD02.6050401@topic.nl> <2808654.KNfBIY3tVp@wuerfel>
 <554CC5A3.7020607@topic.nl>
Message-ID: <5199302.Bhr0olLJXQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 May 2015 16:18:11 Mike Looijmans wrote:
> >
> > If you have that low-memory restriction, you also need to ensure that there
> > is a ZONE_DMA that is large enough. ZONE_DMA should be sized to match the
> > common subset that all devices can access, so a GFP_DMA request returns
> > memory that is guaranteed to be accessible by all devices.
> 
> GFP_DMA still carries that scary remark: "on x86, GFP_DMA guarantees to be 
> within the first 16MB of available bus addresses". Which is really scary if 
> you want to allocate multimegabyte buffers.

Don't worry about that on ARM: the size of the dma zone is platform specific,
so you can set it to whatever you want. The 16MB limit is only relevant
on systems that use ISA DMA (floppy, soundblaster, ...)

	Arnd
