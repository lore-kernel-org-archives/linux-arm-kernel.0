From: kosaki.motohiro@gmail.com (KOSAKI Motohiro)
Date: Tue, 29 May 2012 20:11:09 -0400
Subject: [PATCHv2 4/4] ARM: dma-mapping: remove custom consistent dma
 region
In-Reply-To: <1337252085-22039-5-git-send-email-m.szyprowski@samsung.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-5-git-send-email-m.szyprowski@samsung.com>
Message-ID: <4FC5659D.6040805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>   static void *
>   __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
>   	const void *caller)
>   {
> -	struct arm_vmregion *c;
> -	size_t align;
> -	int bit;
> +	struct vm_struct *area;
> +	unsigned long addr;
> 
> -	if (!consistent_pte) {
> -		printk(KERN_ERR "%s: not initialised\n", __func__);
> +	area = get_vm_area_caller(size, VM_DMA | VM_USERMAP, caller);

In this patch, VM_DMA is only used here. So, is this no effect?
