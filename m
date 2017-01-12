From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jan 2017 14:25:54 +0100
Subject: [PATCH 1/2] dma-mapping: let arch know origin of dma range passed
 to arch_setup_dma_ops()
In-Reply-To: <20170112121623.GH1771@arm.com>
References: <dca35acf-1adf-aa85-7a0b-d0c6ec702fa1@arm.com>
 <764334db-3400-58c6-cc4b-3f7ce66daa27@cogentembedded.com>
 <20170112121623.GH1771@arm.com>
Message-ID: <3273119.LjYLKcrNcz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, January 12, 2017 12:16:24 PM CET Will Deacon wrote:
> On Thu, Jan 12, 2017 at 08:52:51AM +0300, Nikita Yushchenko wrote:
> > >> diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
> > >> index 5ac373c..480b644 100644
> > >> --- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
> > >> +++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
> > >> @@ -540,7 +540,7 @@ int fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
> > >>  
> > >>    /* Objects are coherent, unless 'no shareability' flag set. */
> > >>    if (!(obj_desc->flags & DPRC_OBJ_FLAG_NO_MEM_SHAREABILITY))
> > >> -          arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
> > >> +          arch_setup_dma_ops(&mc_dev->dev, 0, 0, false, NULL, true);
> > >>  
> > >>    /*
> > >>     * The device-specific probe callback will get invoked by device_add()
> > > 
> > > Why are these actually calling arch_setup_dma_ops() here in the first
> > > place? Are these all devices that are DMA masters without an OF node?
> > 
> > I don't know, but that's a different topic. This patch just adds
> > argument and sets it to false everywhere but in the location when range
> > should be definitely enforced.
> 
> I also wouldn't lose any sleep over a staging driver.

I think this is in the process of being moved out of staging, and
my question was about the other two as well:

drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
drivers/iommu/rockchip-iommu.c

	Arnd
