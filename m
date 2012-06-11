From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 11 Jun 2012 14:27:34 +0200
Subject: [PATCH 1/1] ARM: dma-mapping: Add missing static storage class
 specifier
In-Reply-To: <1338805092-892-1-git-send-email-sachin.kamat@linaro.org>
References: <1338805092-892-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <03f301cd47cd$969aaf40$c3d00dc0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday, June 04, 2012 12:18 PM Sachin Kamat wrote:

> Fixes the following sparse warnings:
> arch/arm/mm/dma-mapping.c:231:15: warning: symbol 'consistent_base' was not declared. Should
> it be static?
> arch/arm/mm/dma-mapping.c:326:8: warning: symbol 'coherent_pool_size' was not declared. Should
> it be static?
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>

Thanks for the patch. I've applied it to my dma-mapping fixes branch.

> ---
>  arch/arm/mm/dma-mapping.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index ea6b431..788acb7 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -228,7 +228,7 @@ static pte_t **consistent_pte;
> 
>  #define DEFAULT_CONSISTENT_DMA_SIZE SZ_2M
> 
> -unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
> +static unsigned long consistent_base = CONSISTENT_END - DEFAULT_CONSISTENT_DMA_SIZE;
> 
>  void __init init_consistent_dma_size(unsigned long size)
>  {
> @@ -323,7 +323,7 @@ static struct arm_vmregion_head coherent_head = {
>  	.vm_list	= LIST_HEAD_INIT(coherent_head.vm_list),
>  };
> 
> -size_t coherent_pool_size = DEFAULT_CONSISTENT_DMA_SIZE / 8;
> +static size_t coherent_pool_size = DEFAULT_CONSISTENT_DMA_SIZE / 8;
> 
>  static int __init early_coherent_pool(char *p)
>  {

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
