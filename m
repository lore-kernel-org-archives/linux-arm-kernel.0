From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Aug 2013 21:45:52 +0100
Subject: [PATCH] ARM: dma-mapping: highbank: Restrict DMA to 32-bit
 addresses
In-Reply-To: <20130801204047.GY20842@alberich>
References: <20130801204047.GY20842@alberich>
Message-ID: <20130801204552.GI23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 01, 2013 at 10:40:47PM +0200, Andreas Herrmann wrote:
> 
> Some devices on Calxeda ECX-2000 are restricted to 32-bit DMA. Thus
> the platform needs to set dma_zone_size, otherwise dma-mapping code is
> complaining, e.g.
> 
>   calxedaxgmac fff50000.ethernet: coherent DMA mask 0xffffffff is smaller than system
>     GFP_DMA mask 0xffffffffffffffff
> 
> Same is true for sata_highbank. For the latter dma_coherent_mask could
> be increased but due to the lack of DMA32 zone we need to adapt
> arm_dma_limit in general.

Please wait until I post my dma mask patches.  Thanks.
