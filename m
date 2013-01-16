From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Jan 2013 23:16:31 +0000
Subject: [PATCH] ARM: mm: Fix missing XN flag for for MT_MEMORY_SO
In-Reply-To: <1358347762-14682-1-git-send-email-santosh.shilimkar@ti.com>
References: <1358347762-14682-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130116231631.GW23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 08:19:22PM +0530, Santosh Shilimkar wrote:
> Commit 8fb54284ba6a {ARM: mm: Add strongly ordered descriptor support}
> added XN flag at section level but missed it at PTE level.
> 
> Fix it by adding the L_PTE_XN to MT_MEMORY_SO PET descriptor.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> 
> Reported-by: Richard Woodruff <r-woodruff2@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---

Hmm, yes. => patch system please.

>  arch/arm/mm/mmu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 9f06102..ce328c7 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -283,7 +283,7 @@ static struct mem_type mem_types[] = {
>  	},
>  	[MT_MEMORY_SO] = {
>  		.prot_pte  = L_PTE_PRESENT | L_PTE_YOUNG | L_PTE_DIRTY |
> -				L_PTE_MT_UNCACHED,
> +				L_PTE_MT_UNCACHED | L_PTE_XN,
>  		.prot_l1   = PMD_TYPE_TABLE,
>  		.prot_sect = PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_S |
>  				PMD_SECT_UNCACHED | PMD_SECT_XN,
> -- 
> 1.7.9.5
> 
