From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Sep 2016 14:22:31 +0200
Subject: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
In-Reply-To: <5489283.7nVYvaYEH8@avalon>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <2277430.yNKNTgNkoj@wuerfel> <5489283.7nVYvaYEH8@avalon>
Message-ID: <4397626.d3mSLX4nFk@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 16, 2016 3:09:29 PM CEST Laurent Pinchart wrote:
> > I wasn't thinking quite that far, though that is also a theoretical
> > problem. However, the simple solution would be to have a bit in the DMA
> > specifier let the driver know whether translation is needed or not.
> > 
> > The simpler case I was thinking of is where the entire DMA engine
> > either goes through an IOMMU or doesn't (depending on the integration
> > into the SoC), so we'd have to find out through some DT property
> > or compatible string in the DMA enginen driver.
> 
> Don't we already get that information from the iommus DT property ? If the DMA 
> engine goes through an IOMMU the property will be set, otherwise it will not.

It depends. A dmaengine typically at least has two DMA masters,
possibly more. It's likely that some dmaengine implementations are
connected to RAM through an IOMMU, but have direct access to an
I/O bus for the slave FIFOs.

> > > The problem is a bit broader than that, we'll also have an issue with DMA
> > > engines that have different channels served by different IOMMUs.
> > 
> > Do you mean a theoretical problem, or a chip that you already know exists?
> 
> That's theoretical. The problem I'm facing today is a DMA engine whose 
> channels are served by different ports of the same IOMMU. This works in a 
> suboptimal way because I have to keep all the IOMMU ports enabled regardless 
> of whether they're used or not, as the DMA engine and IOMMU APIs don't carry 
> channel information.

Ok

	Arnd
