From: clemens@ladisch.de (Clemens Ladisch)
Date: Fri, 29 Jun 2012 13:09:55 +0200
Subject: [PATCH] common: dma-mapping: add support for generic dma_mmap_*
 calls
In-Reply-To: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
References: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4FED8D03.10507@ladisch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> +++ b/drivers/base/dma-mapping.c
> ...
> +int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> +		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
> +{
> +	int ret = -ENXIO;
> +	...
> +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> +		return ret;

This will return -ENXIO if dma_mmap_from_coherent() succeeds.


Regards,
Clemens
