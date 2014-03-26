From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Mar 2014 11:00:30 +0000
Subject: [PATCH V2 3/3] arm: mm: Switch back to L_PTE_WRITE
In-Reply-To: <1393328334-27285-4-git-send-email-steve.capper@linaro.org>
References: <1393328334-27285-1-git-send-email-steve.capper@linaro.org>
 <1393328334-27285-4-git-send-email-steve.capper@linaro.org>
Message-ID: <20140326110030.GB6971@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 25, 2014 at 11:38:54AM +0000, Steve Capper wrote:
> --- a/arch/arm/include/asm/pgtable-3level.h
> +++ b/arch/arm/include/asm/pgtable-3level.h
> @@ -86,6 +86,7 @@
>  #define L_PTE_DIRTY            (_AT(pteval_t, 1) << 55)        /* unused */
>  #define L_PTE_SPECIAL          (_AT(pteval_t, 1) << 56)        /* unused */
>  #define L_PTE_NONE             (_AT(pteval_t, 1) << 57)        /* PROT_NONE */
> +#define L_PTE_WRITE            (_AT(pteval_t, 1) << 58)

I think we could rename L_PTE_RDONLY just to PTE_RDONLY since it's a
hardware bit and only used by LPAE.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
