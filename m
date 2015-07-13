From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jul 2015 15:16:30 +0100
Subject: [PATCH v2 04/10] arm64/debug: Eliminate magic number from ESR
 template definition
In-Reply-To: <1436793967-7138-5-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-5-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150713141630.GD19083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 02:25:51PM +0100, Dave P Martin wrote:
> <asm/esr.h> has perfectly good constants for defining ESR values
> already.  Let's use them.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> ---
>  arch/arm64/include/asm/debug-monitors.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index ab7d5a8..ff09058 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -18,6 +18,7 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/esr.h>
>  #include <asm/insn.h>
>  
>  /* Low-level stepping controls. */
> @@ -45,7 +46,8 @@
>  /*
>   * ESR values expected for dynamic and compile time BRK instruction
>   */
> -#define DBG_ESR_VAL_BRK(x)	(0xf2000000 | ((x) & 0xffff))
> +#define DBG_ESR_VAL_BRK(x) \
> +	((ESR_ELx_EC_BRK64 << ESR_ELx_EC_SHIFT) | ESR_ELx_IL | ((x) & 0xffff))

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

>  
>  /*
>   * #imm16 values used for BRK instruction generation
> -- 
> 1.7.10.4
> 
