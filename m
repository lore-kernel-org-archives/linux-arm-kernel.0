From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 31 May 2018 09:12:47 -0700
Subject: [PATCH v4 2/2] drm/nouveau: tegra: Detach from ARM DMA/IOMMU
 mapping
In-Reply-To: <20180530140625.21247-3-thierry.reding@gmail.com>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
 <20180530140625.21247-3-thierry.reding@gmail.com>
Message-ID: <20180531161247.GA10203@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
> +	if (dev->archdata.mapping) {
> +		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +
> +		arm_iommu_detach_device(dev);
> +		arm_iommu_release_mapping(mapping);
> +	}
> +#endif

Having this hidden in a helper would be nicer, but anything that
doesn't directly expose the dma_map_ops to a driver is fine with me.

So from the dma-mapping POV:

Acked-by: Christoph Hellwig <hch@lst.de>
