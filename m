From: will.deacon@arm.com (Will Deacon)
Date: Tue, 28 Oct 2014 12:36:11 +0000
Subject: [PATCH] arm64: ARCH_PFN_OFFSET should be unsigned long
In-Reply-To: <1414475041-31480-1-git-send-email-zhangwm@marvell.com>
References: <1414475041-31480-1-git-send-email-zhangwm@marvell.com>
Message-ID: <20141028123610.GC12136@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 05:44:01AM +0000, Neil Zhang wrote:
> pfns are unsigned long, but PHYS_PFN_OFFSET is phys_addr_t. This leads
> to page_to_pfn() returning phys_addr_t which cause type mismatches in
> some print statements.

Do you have a specific example? Both of those types are 64-bit on arm64.

Will

> Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> ---
>  arch/arm64/include/asm/memory.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index ccc7087..a62cd07 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -142,7 +142,7 @@ static inline void *phys_to_virt(phys_addr_t x)
>   *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
>   *  virt_addr_valid(k)	indicates whether a virtual address is valid
>   */
> -#define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
> +#define ARCH_PFN_OFFSET		((unsigned long)PHYS_PFN_OFFSET)
>  
>  #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>  #define	virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> -- 
> 1.7.9.5
> 
> 
