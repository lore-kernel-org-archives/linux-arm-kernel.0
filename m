From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 23 Nov 2013 19:43:45 -0800
Subject: [PATCH] CMA: Fix the phys_addr_t print types
In-Reply-To: <1385264221-29952-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385264221-29952-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20131124034345.GA3873@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 10:37:01PM -0500, Santosh Shilimkar wrote:
> Otherwise prints would truncate the variables on LPAE machines.
> 
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  drivers/base/dma-contiguous.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 165c2c2..b303a98 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -201,9 +201,8 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  	phys_addr_t alignment;
>  	int ret = 0;
>  
> -	pr_debug("%s(size %lx, base %08lx, limit %08lx)\n", __func__,
> -		 (unsigned long)size, (unsigned long)base,
> -		 (unsigned long)limit);
> +	pr_info("%s(size %pa, base %pa, limit %pa)\n", __func__,
> +		 &size, &base, &limit);

Why did you change the logging level of this message?
