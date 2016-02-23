From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Feb 2016 17:12:41 +0000
Subject: [RFC PATCH 05/10] arm64: mm: avoid __pa translations in
 early_fixmap_init
In-Reply-To: <1456174472-30028-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1456174472-30028-1-git-send-email-ard.biesheuvel@linaro.org>
 <1456174472-30028-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160223171241.GE4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 09:54:27PM +0100, Ard Biesheuvel wrote:
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -679,7 +679,7 @@ void __init early_fixmap_init(void)
>  
>  	pgd = pgd_offset_k(addr);
>  	if (CONFIG_PGTABLE_LEVELS > 3 &&
> -	    !(pgd_none(*pgd) || pgd_page_paddr(*pgd) == __pa(bm_pud))) {
> +	    !(pgd_none(*pgd) || pgd_page_paddr(*pgd) == __pa_symbol(bm_pud))) {
>  		/*
>  		 * We only end up here if the kernel mapping and the fixmap
>  		 * share the top level pgd entry, which should only happen on

Do I miss any patches? The for-next/core branch has a pgd_none(*pgd)
check here, so this patch does not apply.

-- 
Catalin
