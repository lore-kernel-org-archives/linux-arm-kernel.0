From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 25 Oct 2011 13:45:27 +0200 (CEST)
Subject: [PATCH] ARM: remove NR_IRQS dependency for ARM-specific
	HARDIRQ_BITS definition
In-Reply-To: <1319541948-10035-1-git-send-email-khilman@ti.com>
References: <1319541948-10035-1-git-send-email-khilman@ti.com>
Message-ID: <alpine.LFD.2.02.1110251343580.31312@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Oct 2011, Kevin Hilman wrote:

> As a first step towards removing NR_IRQS, remove the ARM customization
> of HARDIRQ_BITS based on NR_IRQS.
> 
> The generic code in <linux/hardirq.h> already has a default value of
> 10 for HARDIRQ_BITS which is the max used on ARM, so let's just remove
> the NR_IRQS based customization and use the generic default.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>

> ---
>  arch/arm/include/asm/hardirq.h |   17 -----------------
>  1 files changed, 0 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
> index 89ad180..96cb097 100644
> --- a/arch/arm/include/asm/hardirq.h
> +++ b/arch/arm/include/asm/hardirq.h
> @@ -30,23 +30,6 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
>  
>  #define arch_irq_stat_cpu	smp_irq_stat_cpu
>  
> -#if NR_IRQS > 512
> -#define HARDIRQ_BITS	10
> -#elif NR_IRQS > 256
> -#define HARDIRQ_BITS	9
> -#else
> -#define HARDIRQ_BITS	8
> -#endif
> -
> -/*
> - * The hardirq mask has to be large enough to have space
> - * for potentially all IRQ sources in the system nesting
> - * on a single CPU:
> - */
> -#if (1 << HARDIRQ_BITS) < NR_IRQS
> -# error HARDIRQ_BITS is too low!
> -#endif
> -
>  #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
>  
>  #endif /* __ASM_HARDIRQ_H */
> -- 
> 1.7.3.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
