From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sun, 13 Nov 2016 11:41:30 +0000
Subject: [PATCH v3 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <7d54803d32968be46a1a525d7160feb13af72f00.1478887214.git.robin.murphy@arm.com>
References: <7d54803d32968be46a1a525d7160feb13af72f00.1478887214.git.robin.murphy@arm.com>
Message-ID: <20161113114129.GA24837@MBP.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 06:27:34PM +0000, Robin Murphy wrote:
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index c5ab8667e6f2..8b745260b3bc 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -432,13 +432,12 @@ int iommu_dma_mmap(struct page **pages, size_t size, struct vm_area_struct *vma)
>  	return ret;
>  }
>  
> -dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> -		unsigned long offset, size_t size, int prot)
> +dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
> +		size_t size, int prot)

This should be static.

-- 
Catalin
