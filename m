From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 4 Sep 2017 09:20:00 +0100
Subject: [PATCH] ARM: dma-mapping: Do not pass data to gen_pool_set_algo()
In-Reply-To: <1502700619-44809-1-git-send-email-vladimir.murzin@arm.com>
References: <1502700619-44809-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <feb85942-bbfe-4644-7ea3-4a969ed0e7f8@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/08/17 09:50, Vladimir Murzin wrote:
> gen_pool_first_fit_order_align() does not make use of additional data,
> so pass plain NULL there.
> 
> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
> ---
>  arch/arm/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index fcf1473..785606e 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -443,7 +443,7 @@ static int __init atomic_pool_init(void)
>  
>  		gen_pool_set_algo(atomic_pool,
>  				gen_pool_first_fit_order_align,
> -				(void *)PAGE_SHIFT);
> +				NULL);
>  		pr_info("DMA: preallocated %zu KiB pool for atomic coherent allocations\n",
>  		       atomic_pool_size / 1024);
>  		return 0;
> 

Ok for patch tracker?

Vladimir
