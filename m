From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jul 2015 15:18:30 +0100
Subject: [PATCH v2 06/10] arm64/debug: Move BRK ESR template macro into
 <asm/esr.h>
In-Reply-To: <1436793967-7138-7-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-7-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150713141830.GE19083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 02:25:53PM +0100, Dave P Martin wrote:
> It makes sense to keep all the architectural exception syndrome
> definitions in the same place.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

It might make sense to merge this with the previous patch, but either
way:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/debug-monitors.h |    7 -------
>  arch/arm64/include/asm/esr.h            |    7 +++++++
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index bb97e9d..e28b1dd 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -44,13 +44,6 @@
>  #define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
>  
>  /*
> - * ESR values expected for dynamic and compile time BRK instruction
> - */
> -#define ESR_ELx_VAL_BRK64(imm)					\
> -	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
> -	 ((imm) & 0xffff))
> -
> -/*
>   * #imm16 values used for BRK instruction generation
>   * Allowed values for kgbd are 0x400 - 0x7ff
>   * 0x100: for triggering a fault on purpose (reserved)
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index 8dab2a9..7568d14 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -101,6 +101,13 @@
>  #define ESR_ELx_WFx_ISS_WFE	(UINT(1) << 0)
>  #define ESR_ELx_xVC_IMM_MASK	((UINT(1) << 16) - 1)
>  
> +/* ESR value templates for specific events */
> +
> +/* BRK instruction trap from AArch64 state */
> +#define ESR_ELx_VAL_BRK64(imm)					\
> +	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL |	\
> +	 ((imm) & 0xffff))
> +
>  #ifndef __ASSEMBLY__
>  #include <asm/types.h>
>  
> -- 
> 1.7.10.4
> 
