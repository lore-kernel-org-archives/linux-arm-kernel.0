From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Wed, 30 Jun 2010 22:59:33 +0300
Subject: [PATCH 04/33] Removing dead MSM7X00A_IDLE
In-Reply-To: <c7e75d44aebaaabfdff9cf5fbda54512d0062728.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<c7e75d44aebaaabfdff9cf5fbda54512d0062728.1277911346.git.siccegge@cs.fau.de>
Message-ID: <20100630195933.GD3969@shutemov.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 05:55:03PM +0200, Christoph Egger wrote:
> MSM7X00A_IDLE doesn't exist in Kconfig, therefore removing all
> references for it from the source code.

It was removed in commit 1637de0c9. I'm not sure if it's correct.

Brian Swetland added to CC list.

> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> ---
>  arch/arm/mach-msm/idle.S |   13 -------------
>  1 files changed, 0 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/idle.S b/arch/arm/mach-msm/idle.S
> index 6a94f05..d8e8027 100644
> --- a/arch/arm/mach-msm/idle.S
> +++ b/arch/arm/mach-msm/idle.S
> @@ -20,17 +20,4 @@
>  #include <asm/assembler.h>
>  
>  ENTRY(arch_idle)
> -#ifdef CONFIG_MSM7X00A_IDLE
> -	mrc     p15, 0, r1, c1, c0, 0    /* read current CR    */
> -	bic     r0, r1, #(1 << 2)        /* clear dcache bit   */
> -	bic     r0, r0, #(1 << 12)       /* clear icache bit   */
> -	mcr     p15, 0, r0, c1, c0, 0    /* disable d/i cache  */
> -
> -	mov     r0, #0                   /* prepare wfi value  */
> -	mcr     p15, 0, r0, c7, c10, 0   /* flush the cache    */
> -	mcr     p15, 0, r0, c7, c10, 4   /* memory barrier     */
> -	mcr     p15, 0, r0, c7, c0, 4    /* wait for interrupt */
> -
> -	mcr     p15, 0, r1, c1, c0, 0    /* restore d/i cache  */
> -#endif
>  	mov     pc, lr
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
 Kirill A. Shutemov
