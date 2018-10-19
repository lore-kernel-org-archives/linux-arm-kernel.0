From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Thu, 18 Oct 2018 20:12:02 -0400
Subject: [PATCH 02/10] swiotlb: mark is_swiotlb_buffer static
In-Reply-To: <20181008080246.20543-3-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-3-hch@lst.de>
Message-ID: <20181019001202.GC1251@char.us.oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 08, 2018 at 10:02:38AM +0200, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  include/linux/swiotlb.h | 1 -
>  kernel/dma/swiotlb.c    | 2 +-
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 965be92c33b5..7ef541ce8f34 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
>  #endif
>  
>  extern void swiotlb_print_info(void);
> -extern int is_swiotlb_buffer(phys_addr_t paddr);
>  extern void swiotlb_set_max_segment(unsigned int);
>  
>  extern const struct dma_map_ops swiotlb_dma_ops;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9062b14bc7f4..26d3af52956f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
>  	max_segment = 0;
>  }
>  
> -int is_swiotlb_buffer(phys_addr_t paddr)
> +static int is_swiotlb_buffer(phys_addr_t paddr)
>  {
>  	return paddr >= io_tlb_start && paddr < io_tlb_end;
>  }
> -- 
> 2.19.0
> 
