From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 13 Jul 2015 15:47:22 +0100
Subject: [PATCH v2 01/10] arm64/debug: Eliminate magic number for size of
 BRK instruction
In-Reply-To: <1436793967-7138-2-git-send-email-Dave.Martin@arm.com>
References: <1436793967-7138-1-git-send-email-Dave.Martin@arm.com>
 <1436793967-7138-2-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150713144721.GJ19083@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 02:25:48PM +0100, Dave P Martin wrote:
> The size of an A64 BRK instruction is the same as the size of all other
> A64 instructions, because all A64 instructions are the same size.
> 
> BREAK_INSTR_SIZE is retained for readibility, but it should not be
> an independent constant from AARCH64_INSN_SIZE.

Given BREAK_INSTR_SIZE seems to be used by the core of the KGDB code I
guess we have no choice. ;)

> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/debug-monitors.h |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
> index 40ec68a..f3d2dbd 100644
> --- a/arch/arm64/include/asm/debug-monitors.h
> +++ b/arch/arm64/include/asm/debug-monitors.h
> @@ -18,6 +18,8 @@
>  
>  #ifdef __KERNEL__
>  
> +#include <asm/insn.h>
> +
>  /* Low-level stepping controls. */
>  #define DBG_MDSCR_SS		(1 << 0)
>  #define DBG_SPSR_SS		(1 << 21)
> @@ -38,7 +40,7 @@
>  /*
>   * Break point instruction encoding
>   */
> -#define BREAK_INSTR_SIZE		4
> +#define BREAK_INSTR_SIZE		AARCH64_INSN_SIZE
>  
>  /*
>   * ESR values expected for dynamic and compile time BRK instruction
> -- 
> 1.7.10.4
> 
