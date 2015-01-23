From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Jan 2015 16:27:24 +0100
Subject: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
 arm_iommu_attach_device()
In-Reply-To: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <10179212.ryUUVC9zEx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 January 2015 16:21:49 Laurent Pinchart wrote:
> +/**
> + * arm_iommu_detach_device
> + * @dev: valid struct device pointer
> + *
> + * Detaches the provided device from a previously attached map.
> + * This voids the dma operations (dma_map_ops pointer)
> + */
> +void arm_iommu_detach_device(struct device *dev)
> +{
> +       __arm_iommu_detach_device(dev);
> +       set_dma_ops(dev, NULL);
> +}
>  EXPORT_SYMBOL_GPL(arm_iommu_detach_device);
>  
> 

Would this introduce a regression in the case where the device is
cache coherent and needs arm_coherent_dma_ops set?

	Arnd
