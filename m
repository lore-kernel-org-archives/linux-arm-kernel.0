From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 22 Nov 2010 13:38:20 -0500 (EST)
Subject: [PATCH v2 9/9] ARM: kprobes: Don't HAVE_KPROBES when
	CONFIG_THUMB2_KERNEL is selected
In-Reply-To: <1290449065-28843-10-git-send-email-dave.martin@linaro.org>
References: <1290449065-28843-1-git-send-email-dave.martin@linaro.org>
	<1290449065-28843-10-git-send-email-dave.martin@linaro.org>
Message-ID: <alpine.LFD.2.00.1011221336060.9313@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Nov 2010, Dave Martin wrote:

> Currently, the kprobes implementation for ARM only supports
> the ARM instruction set, so it only works if
> CONFIG_THUMB2_KERNEL is not enabled.
> 
> Until kprobes is updated to work with Thumb-2, turning it on
> will cause horrible things to happen, so this patch disables it
> for now.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index db524e7..f1d9297 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -9,7 +9,7 @@ config ARM
>  	select GENERIC_ATOMIC64 if (!CPU_32v6K || !AEABI)
>  	select HAVE_OPROFILE if (HAVE_PERF_EVENTS)
>  	select HAVE_ARCH_KGDB
> -	select HAVE_KPROBES if (!XIP_KERNEL)
> +	select HAVE_KPROBES if (!XIP_KERNEL && !THUMB2_KERNEL)
>  	select HAVE_KRETPROBES if (HAVE_KPROBES)
>  	select HAVE_FUNCTION_TRACER if (!XIP_KERNEL)
>  	select HAVE_FTRACE_MCOUNT_RECORD if (!XIP_KERNEL)
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
