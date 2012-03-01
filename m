From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 1 Mar 2012 10:13:22 +0000
Subject: [PATCH 2/7] Add various hugetlb page table fix
In-Reply-To: <1329126268-11032-3-git-send-email-bill4carson@gmail.com>
References: <1329126268-11032-1-git-send-email-bill4carson@gmail.com>
 <1329126268-11032-3-git-send-email-bill4carson@gmail.com>
Message-ID: <20120301101321.GC21445@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2012 at 09:44:23AM +0000, Bill Carson wrote:
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -236,6 +244,7 @@ PTE_BIT_FUNC(mkdirty,   |= L_PTE_DIRTY);
>  PTE_BIT_FUNC(mkold,     &= ~L_PTE_YOUNG);
>  PTE_BIT_FUNC(mkyoung,   |= L_PTE_YOUNG);
>  
> +static inline pte_t pte_mkhuge(pte_t pte) { return pte; }

Do we need to set the PMD_TYPE_SECT here or you just do it via
set_huge_pte()?

-- 
Catalin
