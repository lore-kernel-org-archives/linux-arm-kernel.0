From: ren_guo@c-sky.com (Guo Ren)
Date: Mon, 5 Nov 2018 23:47:50 +0800
Subject: [PATCH 8/9] csky: don't use GFP_DMA in atomic_pool_init
In-Reply-To: <20181105121931.13481-9-hch@lst.de>
References: <20181105121931.13481-1-hch@lst.de>
 <20181105121931.13481-9-hch@lst.de>
Message-ID: <20181105154750.GB25126@guoren-Inspiron-7460>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 01:19:30PM +0100, Christoph Hellwig wrote:
> csky does not implement ZONE_DMA, which means passing GFP_DMA is a no-op.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/csky/mm/dma-mapping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
> index 85437b21e045..ad4046939713 100644
> --- a/arch/csky/mm/dma-mapping.c
> +++ b/arch/csky/mm/dma-mapping.c
> @@ -35,7 +35,7 @@ static int __init atomic_pool_init(void)
>  	if (!atomic_pool)
>  		BUG();
>  
> -	page = alloc_pages(GFP_KERNEL | GFP_DMA, get_order(size));
> +	page = alloc_pages(GFP_KERNEL, get_order(size));
>  	if (!page)
>  		BUG();
>  
> -- 
> 2.19.1

Acked-by: Guo Ren <ren_guo@c-sky.com>
