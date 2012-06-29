From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 29 Jun 2012 15:00:37 +0200
Subject: [PATCH] common: dma-mapping: add support for generic dma_mmap_*
 calls
In-Reply-To: <4FED8D03.10507@ladisch.de>
References: <1339741135-7841-1-git-send-email-m.szyprowski@samsung.com>
 <4FED8D03.10507@ladisch.de>
Message-ID: <00a501cd55f7$323946f0$96abd4d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday, June 29, 2012 1:10 PM Clemens Ladisch wrote:

> Marek Szyprowski wrote:
> > +++ b/drivers/base/dma-mapping.c
> > ...
> > +int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
> > +		    void *cpu_addr, dma_addr_t dma_addr, size_t size)
> > +{
> > +	int ret = -ENXIO;
> > +	...
> > +	if (dma_mmap_from_coherent(dev, vma, cpu_addr, size, &ret))
> > +		return ret;
> 
> This will return -ENXIO if dma_mmap_from_coherent() succeeds.
 
Thanks for spotting this! I will fix it in the next version of the patch.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
