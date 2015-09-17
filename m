From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 17 Sep 2015 10:45:34 +0100
Subject: [PATCH 2/7] arm64: Shorten lines which exceed 80 characters
In-Reply-To: <1442430186-9083-3-git-send-email-jeremy.linton@arm.com>
References: <1442430186-9083-1-git-send-email-jeremy.linton@arm.com>
 <1442430186-9083-3-git-send-email-jeremy.linton@arm.com>
Message-ID: <20150917094533.GL25444@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 02:03:01PM -0500, Jeremy Linton wrote:
> PTE definitions in this file exceed 80 characters
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/pgtable-hwdef.h | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> index 24154b0..4489cf6 100644
> --- a/arch/arm64/include/asm/pgtable-hwdef.h
> +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> @@ -99,14 +99,14 @@
>  #define PTE_TYPE_FAULT		(_AT(pteval_t, 0) << 0)
>  #define PTE_TYPE_PAGE		(_AT(pteval_t, 3) << 0)
>  #define PTE_TABLE_BIT		(_AT(pteval_t, 1) << 1)
> -#define PTE_USER		(_AT(pteval_t, 1) << 6)		/* AP[1] */
> -#define PTE_RDONLY		(_AT(pteval_t, 1) << 7)		/* AP[2] */
> -#define PTE_SHARED		(_AT(pteval_t, 3) << 8)		/* SH[1:0], inner shareable */
> -#define PTE_AF			(_AT(pteval_t, 1) << 10)	/* Access Flag */
> -#define PTE_NG			(_AT(pteval_t, 1) << 11)	/* nG */
> -#define PTE_DBM			(_AT(pteval_t, 1) << 51)	/* Dirty Bit Management */
> -#define PTE_PXN			(_AT(pteval_t, 1) << 53)	/* Privileged XN */
> -#define PTE_UXN			(_AT(pteval_t, 1) << 54)	/* User XN */
> +#define PTE_USER		(_AT(pteval_t, 1) << 6)  /* AP[1] */
> +#define PTE_RDONLY		(_AT(pteval_t, 1) << 7)  /* AP[2] */
> +#define PTE_SHARED		(_AT(pteval_t, 3) << 8)  /* inner shareable */
> +#define PTE_AF			(_AT(pteval_t, 1) << 10) /* Access Flag */
> +#define PTE_NG			(_AT(pteval_t, 1) << 11) /* nG */
> +#define PTE_DBM			(_AT(pteval_t, 1) << 51) /* Dirty Bit Mgmt */
> +#define PTE_PXN			(_AT(pteval_t, 1) << 53) /* Privileged XN */
> +#define PTE_UXN			(_AT(pteval_t, 1) << 54) /* User XN */

I told you already ;), I'm not taking this patch. Some (of my) rules for
checkpatch usage:

1. Don't run it on existing code with the aim of fixing it
2. Existing coding style takes precedence over checkpatch warnings

(I have another rule but I don't want to impose it on anyone: I never
run checkpatch)

-- 
Catalin
