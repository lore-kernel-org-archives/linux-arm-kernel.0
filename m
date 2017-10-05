From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 5 Oct 2017 13:22:09 +0100
Subject: [PATCH] arm64: use vma_pages helper
In-Reply-To: <1507205815-5204-1-git-send-email-allen.pais@oracle.com>
References: <1507205815-5204-1-git-send-email-allen.pais@oracle.com>
Message-ID: <722c4481-8d6a-ce95-93c3-07b5bb232d36@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/10/17 13:16, Allen Pais wrote:
>   Use vma_pages function on vma object instead of explicit computation.
>   This is a clean up patch.

A version of this is already queued for -next here:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/commit/?h=for-next/core&id=b4f4a2755665bf847231050b569f587ce0945482

Thanks,
Robin.

> Signed-off-by: Allen Pais <allen.pais@oracle.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 614af88..5f62090 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -303,8 +303,7 @@ static int __swiotlb_mmap_pfn(struct vm_area_struct *vma,
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
