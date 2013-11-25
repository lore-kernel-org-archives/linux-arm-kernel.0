From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 25 Nov 2013 11:47:34 +0100
Subject: [PATCH v2] CMA: Fix the phys_addr_t print types
In-Reply-To: <1385265384-30510-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385265384-30510-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <52932AC6.4090203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2013-11-24 04:56, Santosh Shilimkar wrote:
> Otherwise prints would truncate the variables on LPAE machines.
>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
> Dropped accidental change pr_debug to pr_info from last version.
>
>   drivers/base/dma-contiguous.c |    9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 165c2c2..b303a98 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -201,9 +201,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   	phys_addr_t alignment;
>   	int ret = 0;
>   
> -	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
> -		 (unsigned long)size, (unsigned long)base,
> -		 (unsigned long)limit);
> +	pr_debug("%s(size %pa, base %pa, limit %pa)\n", __func__,
> +		 &size, &base, &limit);
>   
>   	/* Sanity checks */
>   	if (cma_area_count == ARRAY_SIZE(cma_areas)) {
> @@ -250,8 +249,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>   	*res_cma = cma;
>   	cma_area_count++;
>   
> -	pr_info("CMA: reserved %ld MiB at %08lx\n", (unsigned long)size / SZ_1M,
> -		(unsigned long)base);
> +	pr_info("CMA: reserved %ld MiB at %pa\n", (unsigned long)size / SZ_1M,
> +		&base);
>   
>   	/* Architecture specific contiguous memory fixup. */
>   	dma_contiguous_early_fixup(base, size);

Best regards
-- 
Marek Szyprowski
Samsung R&D Institute Poland
