From: niklas.soderlund@ragnatech.se (Niklas =?iso-8859-1?Q?S=F6derlund?=)
Date: Fri, 23 Sep 2016 09:25:00 +0200
Subject: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
 transfers
In-Reply-To: <20160915162650.GZ13920@localhost>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
 <20160810173710.GK9681@localhost>
 <20160915162650.GZ13920@localhost>
Message-ID: <20160923072459.GJ19172@bigcity.dyn.berto.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On 2016-09-15 21:56:51 +0530, Vinod Koul wrote:
> On Wed, Aug 10, 2016 at 11:07:10PM +0530, Vinod Koul wrote:
> > On Wed, Aug 10, 2016 at 01:22:13PM +0200, Niklas S?derlund wrote:
> > > Hi,
> > > 
> > > This series tries to solve the problem with DMA with device registers
> > > (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> > > recent patch '9575632 (dmaengine: make slave address physical)'
> > > clarifies that DMA slave address provided by clients is the physical
> > > address. This puts the task of mapping the DMA slave address from a
> > > phys_addr_t to a dma_addr_t on the DMA engine.
> > > 
> > > Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> > > the same and no special care is needed. However if you have a IOMMU you
> > > need to map the DMA slave phys_addr_t to a dma_addr_t using something
> > > like this.
> > > 
> > > This series is based on top of v4.8-rc1. And I'm hoping to be able to collect a
> > > Ack from Russell King on patch 4/6 that adds the ARM specific part and then be
> > > able to take the whole series through the dmaengine tree. If this is not the
> > > best route I'm more then happy to do it another way.
> > > 
> > > It's tested on a Koelsch with CONFIG_IPMMU_VMSA and by enabling the
> > > ipmmu_ds node in r8a7791.dtsi. I verified operation by interacting with
> > > /dev/mmcblk1, i2c and the serial console which are devices behind the
> > > iommu.
> > 
> > As I said in last one, the dmaengine parts look fine to me. But to go thru
> > dmaengine tree I would need ACK on non dmaengine patches.
> 
> I havent heard back from this one and I am inclined to merge this one now.
> If anyone has any objects, please speak up now...

I'm just curios, do you plan to merge this series with Arnds Ack? If not 
is there anything I can do to help move the series in the right 
direction?

> 
> Also ACKs welcome...
> 

-- 
Regards,
Niklas S?derlund
