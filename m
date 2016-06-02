From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Thu, 2 Jun 2016 14:58:07 +0200
Subject: [PATCHv7 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
In-Reply-To: <20160601180610.GV16910@localhost>
References: <1464794549-6601-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160601180610.GV16910@localhost>
Message-ID: <20160602125807.GN8307@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 2016-06-01 23:36:11 +0530, Vinod Koul wrote:
> On Wed, Jun 01, 2016 at 05:22:23PM +0200, Niklas S?derlund wrote:
> > Hi,
> > 
> > [In this v7 series I have tried to address the questions raised by Christoph 
> > Hellwig and I hope it can awnser your concernes regarding dma-debug.]
> > 
> > This series tries to solve the problem with DMA with device registers
> > (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> > recent patch '9575632 (dmaengine: make slave address physical)'
> > clarifies that DMA slave address provided by clients is the physical
> > address. This puts the task of mapping the DMA slave address from a
> > phys_addr_t to a dma_addr_t on the DMA engine.
> > 
> > Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> > the same and no special care is needed. However if you have a IOMMU you
> > need to map the DMA slave phys_addr_t to a dma_addr_t using something
> > like this.
> > 
> > This series is based on top of v4.7-rc1.
> 
> The dmanegine bits looks okay to me. Btw how is the merge planned for this?
> Do you wnat this to be merged thru dmaengine tree or something else?

Yes, since the arm specific patch are depending on other parts of the 
series I was hoping to be able to get Russells Ack on it and then try to 
get it all in through the dmaengine tree.

If you see a better way I'm happy to do it that way, let me know what 
you think. I hold off v8 that adresses the issues Russell brought up a 
few days untill I know what you think is best.

-- 
Regards,
Niklas S?derlund
