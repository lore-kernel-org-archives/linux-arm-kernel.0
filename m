From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 11 Oct 2018 18:54:06 +0100
Subject: [PATCH 02/10] swiotlb: mark is_swiotlb_buffer static
In-Reply-To: <20181008080246.20543-3-hch@lst.de>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-3-hch@lst.de>
Message-ID: <bfd45ad6-901d-c9a6-2264-4f93684c0fa1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/18 09:02, Christoph Hellwig wrote:

I agree there isn't really a good reason for external code to ever be 
poking at this, despite it being helpful for arch code trying to hack 
around awful coherency issues ;)

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/swiotlb.h | 1 -
>   kernel/dma/swiotlb.c    | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 965be92c33b5..7ef541ce8f34 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -121,7 +121,6 @@ static inline unsigned int swiotlb_max_segment(void) { return 0; }
>   #endif
>   
>   extern void swiotlb_print_info(void);
> -extern int is_swiotlb_buffer(phys_addr_t paddr);
>   extern void swiotlb_set_max_segment(unsigned int);
>   
>   extern const struct dma_map_ops swiotlb_dma_ops;
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 9062b14bc7f4..26d3af52956f 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -429,7 +429,7 @@ void __init swiotlb_exit(void)
>   	max_segment = 0;
>   }
>   
> -int is_swiotlb_buffer(phys_addr_t paddr)
> +static int is_swiotlb_buffer(phys_addr_t paddr)
>   {
>   	return paddr >= io_tlb_start && paddr < io_tlb_end;
>   }
> 
