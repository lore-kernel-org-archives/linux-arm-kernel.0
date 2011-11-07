From: nico@fluxnic.net (Nicolas Pitre)
Date: Sun, 06 Nov 2011 21:59:58 -0500 (EST)
Subject: [PATCH 40/41] ARM: restart: remove comments about adding code to
 arch_reset()
In-Reply-To: <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
References: <20111106173113.GI12913@n2100.arm.linux.org.uk>
 <E1RN6uQ-0001ZK-Rz@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1111062159080.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Nov 2011, Russell King - ARM Linux wrote:

> arch_reset() is deprecated; systems should hook into system restart via
> the 'restart' method in the platforms machine description record.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mach-msm/include/mach/system.h       |    4 ----
>  arch/arm/mach-picoxcell/include/mach/system.h |    1 -
>  arch/arm/mach-ux500/include/mach/system.h     |    1 -
>  arch/arm/mach-zynq/include/mach/system.h      |    1 -
>  4 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-msm/include/mach/system.h b/arch/arm/mach-msm/include/mach/system.h
> index d2e83f4..e180e8b 100644
> --- a/arch/arm/mach-msm/include/mach/system.h
> +++ b/arch/arm/mach-msm/include/mach/system.h
> @@ -12,14 +12,10 @@
>   * GNU General Public License for more details.
>   *
>   */
> -
> -#include <mach/hardware.h>
> -
>  void arch_idle(void);
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	for (;;) ;  /* depends on IPC w/ other core */
>  }
>  
>  /* low level hardware reset hook -- for example, hitting the
> diff --git a/arch/arm/mach-picoxcell/include/mach/system.h b/arch/arm/mach-picoxcell/include/mach/system.h
> index 67c589b..a12da63 100644
> --- a/arch/arm/mach-picoxcell/include/mach/system.h
> +++ b/arch/arm/mach-picoxcell/include/mach/system.h
> @@ -25,7 +25,6 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(int mode, const char *cmd)
>  {
> -	/* Watchdog reset to go here. */
>  }
>  
>  #endif /* __ASM_ARCH_SYSTEM_H */
> diff --git a/arch/arm/mach-ux500/include/mach/system.h b/arch/arm/mach-ux500/include/mach/system.h
> index c0cd800..ae1dff1 100644
> --- a/arch/arm/mach-ux500/include/mach/system.h
> +++ b/arch/arm/mach-ux500/include/mach/system.h
> @@ -19,7 +19,6 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	/* yet to be implemented - TODO */
>  }
>  
>  #endif
> diff --git a/arch/arm/mach-zynq/include/mach/system.h b/arch/arm/mach-zynq/include/mach/system.h
> index 1b84d70..34be7ed 100644
> --- a/arch/arm/mach-zynq/include/mach/system.h
> +++ b/arch/arm/mach-zynq/include/mach/system.h
> @@ -22,7 +22,6 @@ static inline void arch_idle(void)
>  
>  static inline void arch_reset(char mode, const char *cmd)
>  {
> -	/* Add architecture specific reset processing here */
>  }
>  
>  #endif
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
