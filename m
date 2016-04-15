From: will.deacon@arm.com (Will Deacon)
Date: Fri, 15 Apr 2016 16:17:04 +0100
Subject: [PATCH v2 04/17] arm64: Introduce pmd_thp_or_huge
In-Reply-To: <1460640065-27658-5-git-send-email-suzuki.poulose@arm.com>
References: <1460640065-27658-1-git-send-email-suzuki.poulose@arm.com>
 <1460640065-27658-5-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160415151703.GP22906@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 02:20:52PM +0100, Suzuki K Poulose wrote:
> Add a helper to determine if a given pmd represents a huge page
> either by hugetlb or thp, as we have for arm. This will be used
> by KVM MMU code.
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/include/asm/pgtable.h |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 989fef1..dda4aa9 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -290,6 +290,8 @@ static inline pgprot_t mk_sect_prot(pgprot_t prot)
>  #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
>  #define pmd_mknotpresent(pmd)	(__pmd(pmd_val(pmd) & ~PMD_TYPE_MASK))
>  
> +#define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))

Acked-by: Will Deacon <will.deacon@arm.com>

Will
