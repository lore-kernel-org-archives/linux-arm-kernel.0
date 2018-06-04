From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Jun 2018 13:13:51 +0100
Subject: [PATCH v12 3/5] arm64: pgtable: Add p*d_page_vaddr helper macros
In-Reply-To: <1527856758-27169-4-git-send-email-cpandya@codeaurora.org>
References: <1527856758-27169-1-git-send-email-cpandya@codeaurora.org>
 <1527856758-27169-4-git-send-email-cpandya@codeaurora.org>
Message-ID: <20180604121351.GJ9482@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 06:09:16PM +0530, Chintan Pandya wrote:
> Add helper macros to give virtual references to page
> tables. These will be used while freeing dangling
> page tables.
> 
> Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
> ---
>  arch/arm64/include/asm/pgtable.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 7c4c8f3..ef4047f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -580,6 +580,9 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>  
>  #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
>  
> +#define pmd_page_vaddr(pmd) __va(pmd_page_paddr(pmd))
> +#define pud_page_vaddr(pud) __va(pud_page_paddr(pud))

Are these actually needed, or do pte_offset_kernel and pmd_offset do the
job already?

Will
