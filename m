From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 18 Jul 2016 18:03:05 +0200
Subject: [PATCH] ARM: dma-mapping: Use %zu for printing a size_t variable
In-Reply-To: <1468714210-1407-1-git-send-email-festevam@gmail.com>
References: <1468714210-1407-1-git-send-email-festevam@gmail.com>
Message-ID: <7fe0460e-3455-cb37-c961-ca44841abdcb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/17/2016 02:10 AM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
>
> According to Documentation/printk-formats.txt when printing
> a size_t variable we should use %zu or %zx format specifiers.
>
> As we are printing a memory size value, we should better use %zu
> in this case.
>
> Reported-by: Frank Mori Hess <fmh6jj@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/mm/dma-mapping.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 654f202a..5bcf71b 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -436,7 +436,7 @@ static int __init atomic_pool_init(void)
>  		gen_pool_set_algo(atomic_pool,
>  				gen_pool_first_fit_order_align,
>  				(void *)PAGE_SHIFT);
> -		pr_info("DMA: preallocated %zd KiB pool for atomic coherent allocations\n",
> +		pr_info("DMA: preallocated %zu KiB pool for atomic coherent allocations\n",
>  		       atomic_pool_size / 1024);
>  		return 0;
>  	}
> @@ -445,7 +445,7 @@ destroy_genpool:
>  	gen_pool_destroy(atomic_pool);
>  	atomic_pool = NULL;
>  out:
> -	pr_err("DMA: failed to allocate %zx KiB pool for atomic coherent allocation\n",
> +	pr_err("DMA: failed to allocate %zu KiB pool for atomic coherent allocation\n",

size_t should be formated as %zu or %zx so %zx is fine here.

>  	       atomic_pool_size / 1024);
>  	return -ENOMEM;
>  }
>
