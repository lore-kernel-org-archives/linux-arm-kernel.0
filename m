From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Feb 2014 10:09:09 +0000
Subject: [PATCH] arm64: Change misleading function names in dma-mapping
In-Reply-To: <CAD15agZzJ4=RMbky+GymJbyktLz0PO+uZ-GOh1SbvH476k4hzA@mail.gmail.com>
References: <CAD15agZzJ4=RMbky+GymJbyktLz0PO+uZ-GOh1SbvH476k4hzA@mail.gmail.com>
Message-ID: <20140206100909.GC26035@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 06:28:22AM +0000, Ritesh Harjani wrote:
> 
> From: Ritesh Harjani <ritesh.harjani at gmail.com<mailto:ritesh.harjani@gmail.com>>
> 
> arm64_swiotlb_alloc/free_coherent name can be misleading
> somtimes with CMA support being enabled after this
> patch (c2104debc235b745265b64d610237a6833fd53)
> 
> Change this name to be more generic:
> arm64_dma_alloc/free_coherent

I'm fine with this cosmetic change, but the (pre-existing) arm64 prefix looks
a little odd for a static function.

Will

> Signed-off-by: Ritesh Harjani <ritesh.harjani at gmail.com<mailto:ritesh.harjani@gmail.com>>
> ---
>  arch/arm64/mm/dma-mapping.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 45b5ab5..7517796 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -30,7 +30,7 @@
>  struct dma_map_ops *dma_ops;
>  EXPORT_SYMBOL(dma_ops);
> 
> -static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
> +static void *arm64_dma_alloc_coherent(struct device *dev, size_t size,
>                                           dma_addr_t *dma_handle, gfp_t flags,
>                                           struct dma_attrs *attrs)
>  {
> @@ -57,7 +57,7 @@ static void *arm64_swiotlb_alloc_coherent(struct device *dev, size_t size,
>         }
>  }
> 
> -static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
> +static void arm64_dma_free_coherent(struct device *dev, size_t size,
>                                         void *vaddr, dma_addr_t dma_handle,
>                                         struct dma_attrs *attrs)
>  {
> @@ -78,8 +78,8 @@ static void arm64_swiotlb_free_coherent(struct device *dev, size_t size,
>  }
> 
>  static struct dma_map_ops arm64_swiotlb_dma_ops = {
> -       .alloc = arm64_swiotlb_alloc_coherent,
> -       .free = arm64_swiotlb_free_coherent,
> +       .alloc = arm64_dma_alloc_coherent,
> +       .free = arm64_dma_free_coherent,
>         .map_page = swiotlb_map_page,
>         .unmap_page = swiotlb_unmap_page,
>         .map_sg = swiotlb_map_sg_attrs,
> --
> 1.8.1.3
> 
> 
