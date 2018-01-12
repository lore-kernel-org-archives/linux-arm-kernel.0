From: konrad@darnok.org (Konrad Rzeszutek Wilk)
Date: Fri, 12 Jan 2018 08:25:34 -0500
Subject: [PATCH 05/22] x86: rename swiotlb_dma_ops
In-Reply-To: <20180110080932.14157-6-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-6-hch@lst.de>
Message-ID: <20180112132534.GE26900@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 09:09:15AM +0100, Christoph Hellwig wrote:
> We'll need that name for a generic implementation soon.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  arch/x86/kernel/pci-swiotlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
> index 9d3e35c33d94..0d77603c2f50 100644
> --- a/arch/x86/kernel/pci-swiotlb.c
> +++ b/arch/x86/kernel/pci-swiotlb.c
> @@ -48,7 +48,7 @@ void x86_swiotlb_free_coherent(struct device *dev, size_t size,
>  		dma_generic_free_coherent(dev, size, vaddr, dma_addr, attrs);
>  }
>  
> -static const struct dma_map_ops swiotlb_dma_ops = {
> +static const struct dma_map_ops x86_swiotlb_dma_ops = {
>  	.mapping_error = swiotlb_dma_mapping_error,
>  	.alloc = x86_swiotlb_alloc_coherent,
>  	.free = x86_swiotlb_free_coherent,
> @@ -112,7 +112,7 @@ void __init pci_swiotlb_init(void)
>  {
>  	if (swiotlb) {
>  		swiotlb_init(0);
> -		dma_ops = &swiotlb_dma_ops;
> +		dma_ops = &x86_swiotlb_dma_ops;
>  	}
>  }
>  
> -- 
> 2.14.2
> 
