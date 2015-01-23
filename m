From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 23 Jan 2015 17:55:25 +0200
Subject: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
 arm_iommu_attach_device()
In-Reply-To: <10179212.ryUUVC9zEx@wuerfel>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <10179212.ryUUVC9zEx@wuerfel>
Message-ID: <2416515.WUUq1g4kPD@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Friday 23 January 2015 16:27:24 Arnd Bergmann wrote:
> On Friday 23 January 2015 16:21:49 Laurent Pinchart wrote:
> > +/**
> > + * arm_iommu_detach_device
> > + * @dev: valid struct device pointer
> > + *
> > + * Detaches the provided device from a previously attached map.
> > + * This voids the dma operations (dma_map_ops pointer)
> > + */
> > +void arm_iommu_detach_device(struct device *dev)
> > +{
> > +       __arm_iommu_detach_device(dev);
> > +       set_dma_ops(dev, NULL);
> > +}
> > 
> >  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
> 
> Would this introduce a regression in the case where the device is
> cache coherent and needs arm_coherent_dma_ops set?

I think we need to handle that case (as well as the coherent IOMMU case in 
arm_iommu_attach_device), but this patch only tries to restore the previous 
behaviour to fix the bug detailed in the commit message. Would you prefer 
fixing both issues in one go ?

-- 
Regards,

Laurent Pinchart
