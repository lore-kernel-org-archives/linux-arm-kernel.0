From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 17 Jul 2014 11:49:09 +0100
Subject: [PATCH v7 02/11] arm64: Remove duplicate
 (SWAPPER|IDMAP)_DIR_SIZE definitions
In-Reply-To: <1405537792-23666-3-git-send-email-catalin.marinas@arm.com>
References: <1405537792-23666-1-git-send-email-catalin.marinas@arm.com>
 <1405537792-23666-3-git-send-email-catalin.marinas@arm.com>
Message-ID: <20140717104909.GI30313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 08:09:43PM +0100, Catalin Marinas wrote:
> Just keep the asm/page.h definition as this is included in vmlinux.lds.S
> as well.

My bad, I should've spotted that when I moved idmap and swapper next to
the BSS. Thanks for cleaning this up.

I guess we got lucky with nothing including both pgtable.h and page.h? I
don't recall seeing any duplicate definition warnings.

> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index e0ccceb317d9..d7455fa83bc7 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -383,9 +383,6 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
>  extern pgd_t idmap_pg_dir[PTRS_PER_PGD];
>  
> -#define SWAPPER_DIR_SIZE	(3 * PAGE_SIZE)
> -#define IDMAP_DIR_SIZE		(2 * PAGE_SIZE)
> -
>  /*
>   * Encode and decode a swap entry:
>   *	bits 0-1:	present (must be zero)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
