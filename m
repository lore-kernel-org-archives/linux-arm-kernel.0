From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 11 Oct 2017 17:52:46 +0100
Subject: [PATCH v2 1/2] arm64: Use existing defines for mdscr
In-Reply-To: <1507729721-53978-2-git-send-email-julien.thierry@arm.com>
References: <1507729721-53978-1-git-send-email-julien.thierry@arm.com>
 <1507729721-53978-2-git-send-email-julien.thierry@arm.com>
Message-ID: <20171011165245.GA26449@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Oct 11, 2017 at 02:48:40PM +0100, Julien Thierry wrote:
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/include/asm/assembler.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
> index d58a625..00a4526 100644
> --- a/arch/arm64/include/asm/assembler.h
> +++ b/arch/arm64/include/asm/assembler.h
> @@ -30,6 +30,7 @@
>  #include <asm/pgtable-hwdef.h>
>  #include <asm/ptrace.h>
>  #include <asm/thread_info.h>
> +#include <asm/debug-monitors.h>

Nit: please keep these ordered alphabetically.

Otherwise, this is much nicer! FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> 
>  /*
>   * Enable and disable interrupts.
> @@ -65,7 +66,7 @@
>  	.macro	disable_step_tsk, flgs, tmp
>  	tbz	\flgs, #TIF_SINGLESTEP, 9990f
>  	mrs	\tmp, mdscr_el1
> -	bic	\tmp, \tmp, #1
> +	bic	\tmp, \tmp, #DBG_MDSCR_SS
>  	msr	mdscr_el1, \tmp
>  	isb	// Synchronise with enable_dbg
>  9990:
> @@ -75,7 +76,7 @@
>  	tbz	\flgs, #TIF_SINGLESTEP, 9990f
>  	disable_dbg
>  	mrs	\tmp, mdscr_el1
> -	orr	\tmp, \tmp, #1
> +	orr	\tmp, \tmp, #DBG_MDSCR_SS
>  	msr	mdscr_el1, \tmp
>  9990:
>  	.endm
> --
> 1.9.1
