From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 14 Jan 2015 10:22:05 +0100
Subject: [PATCH] ARM: mm: Fix dma_contiguous_reserve comment
In-Reply-To: <1420823548-37979-1-git-send-email-george_davis@mentor.com>
References: <1420823548-37979-1-git-send-email-george_davis@mentor.com>
Message-ID: <54B6353D.8050109@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-01-09 18:12, George G. Davis wrote:
> DMA contiguous allocations have been able to use highmem since commit
> "95b0e65 ARM: mm: don't limit default CMA region only to low memory"
> but a comment still notes the earlier "low memory" limitation.  Update
> the comment to remove the low memory limitation and fix the
> s/contigouos/contiguous/ typo while we're at it.
>
> Signed-off-by: George G. Davis <george_davis@mentor.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>   arch/arm/mm/init.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 98ad9c7..d538dc7 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -319,10 +319,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
>   
>   	early_init_fdt_scan_reserved_mem();
>   
> -	/*
> -	 * reserve memory for DMA contigouos allocations,
> -	 * must come from DMA area inside low memory
> -	 */
> +	/* reserve memory for DMA contiguous allocations */
>   	dma_contiguous_reserve(arm_dma_limit);
>   
>   	arm_memblock_steal_permitted = false;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
