From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 28 Mar 2012 08:10:20 +0200
Subject: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
In-Reply-To: <4F7275FE.8000100@mprc.pku.edu.cn>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
 <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
 <4F7275FE.8000100@mprc.pku.edu.cn>
Message-ID: <00ac01cd0ca9$7508f4e0$5f1adea0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, March 28, 2012 4:23 AM Guan Xuetao wrote:

> On 03/27/2012 09:42 PM, Marek Szyprowski wrote:
> > diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
> > index bfa9fbb..4cf5f0c 100644
> > --- a/arch/unicore32/mm/dma-swiotlb.c
> > +++ b/arch/unicore32/mm/dma-swiotlb.c
> > @@ -17,9 +17,23 @@
> >
> >   #include<asm/dma.h>
> >
> > +static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
> > +					    dma_addr_t *dma_handle, gfp_t flags,
> > +					    struct dma_attrs *attrs)
> > +{
> > +	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
> > +}
> > +
> > +static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
> The bit is ok for me. Only a typo here, please change unicode to unicore.

Ups, I'm sorry for that typo. I've fixed it on my git tree:

http://git.linaro.org/gitweb?p=people/mszyprowski/linux-dma-mapping.git;a=commitdiff;h=bbe43c05b0653
9c09f89e07bcaf61ea0fca8d67f

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
