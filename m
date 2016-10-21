From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 21 Oct 2016 11:18:55 +0100
Subject: [PATCH] arm64: mm: fix __page_to_voff definition
In-Reply-To: <1477040326-21260-1-git-send-email-neeraju@codeaurora.org>
References: <1477040326-21260-1-git-send-email-neeraju@codeaurora.org>
Message-ID: <CAKv+Gu9gQnaxhPx16v6WiS6Qdcdu8VJraKskMxhF97A4uGhSrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 October 2016 at 09:58, Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> Fix parameter name for __page_to_voff, to match its definition.
> At present, we don't see any issue, as page_to_virt's caller
> declares 'page'.
>
> Fixes: 9f2875912dac ("arm64: mm: restrict virt_to_page() to the linear mapping")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  arch/arm64/include/asm/memory.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index ba62df8..b71086d 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -217,7 +217,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>  #define _virt_addr_valid(kaddr)        pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
>  #else
>  #define __virt_to_pgoff(kaddr) (((u64)(kaddr) & ~PAGE_OFFSET) / PAGE_SIZE * sizeof(struct page))
> -#define __page_to_voff(kaddr)  (((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
> +#define __page_to_voff(page)   (((u64)(page) & ~VMEMMAP_START) * PAGE_SIZE / sizeof(struct page))
>
>  #define page_to_virt(page)     ((void *)((__page_to_voff(page)) | PAGE_OFFSET))
>  #define virt_to_page(vaddr)    ((struct page *)((__virt_to_pgoff(vaddr)) | VMEMMAP_START))

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
