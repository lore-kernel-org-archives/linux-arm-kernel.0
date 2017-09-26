From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Sep 2017 12:57:15 +0100
Subject: [PATCH 2/7] arm64: Cocci spatch "vma_pages"
In-Reply-To: <1505946334393-397244072-2-diffsplit-thomas@m3y3r.de>
References: <1505946334393-568186305-0-diffsplit-thomas@m3y3r.de>
 <1505946334393-397244072-2-diffsplit-thomas@m3y3r.de>
Message-ID: <8d4fa6de-f8e2-f073-cfc8-ce78947ad599@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/17 23:29, Thomas Meyer wrote:
> Use vma_pages function on vma object instead of explicit computation.
> Found by coccinelle spatch "api/vma_pages.cocci"

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I guess this can be picked up independently of the other patches?

Robin.

> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
> 
> diff -u -p a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -303,8 +303,7 @@ static int __swiotlb_mmap_pfn(struct vm_
>  			      unsigned long pfn, size_t size)
>  {
>  	int ret = -ENXIO;
> -	unsigned long nr_vma_pages = (vma->vm_end - vma->vm_start) >>
> -					PAGE_SHIFT;
> +	unsigned long nr_vma_pages = vma_pages(vma);
>  	unsigned long nr_pages = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	unsigned long off = vma->vm_pgoff;
>  
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
