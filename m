From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Feb 2013 09:59:38 +0000
Subject: ARM coherent allocs, Was: ixp4xx eth broken in 3.7.0/3.8-rc5?
In-Reply-To: <20769.61349.124371.633959@pilspetsen.it.uu.se>
References: <20744.9777.937924.822371@pilspetsen.it.uu.se>
 <m34nhk9ef7.fsf@intrepid.localdomain>
 <m3a9r2d5md.fsf_-_@intrepid.localdomain>
 <20769.61349.124371.633959@pilspetsen.it.uu.se>
Message-ID: <20130218095938.GS17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 10:08:53AM +0100, Mikael Pettersson wrote:
> Krzysztof Halasa writes:
>  > Hi,
>  > 
>  > I'm not sure how is it supposed to work. Environment: IXP4xx CPU,
>  > only 64 MB (of 256 MB) of RAM is available for PCI bus master DMA,
>  > /dev/sda is a PATA CF or SATA SSD using CS5536-based PATA interface
>  > (SATA - with a bridge) in DMA (PCI bus master) mode.
>  > 
>  > It works in PIO mode.
>  > The problem seems to be this: pci_dev->dev.coherent_dma_mask is 0x3FFFFFF
>  > (64MB-1). Yet __dma_alloc() called with GFP_DMA returns memory
>  > physically located (dma_handle) above 64MB region.
> 
> Isn't that what the ARM-specific dma bounce allocator is supposed to
> handle?  Or did e9da6e9905e639b0f842a244bc770b48ad0523e9 disable that one?

How can it if the coherent DMA allocator is not respecting the DMA mask?
