From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 20 Jun 2016 10:28:29 +0900
Subject: [PATCH] ARM: remove unused CONFIG_ARCH_HAS_BARRIERS
In-Reply-To: <1465820748-7369-1-git-send-email-yamada.masahiro@socionext.com>
References: <1465820748-7369-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNARgob3qEvoxdLWxeg15tPB8n5zLk1WYX-AUroPgkH0e5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

I have not had any comment on this patch,
but it looks correct to me.

I will put it into Russell's patch tracker
if nobody is against it.



2016-06-13 21:25 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Since commit 2b749cb3a515 ("ARM: realview: remove private barrier
> implementation"), this config is not used by any platform.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/include/asm/barrier.h | 4 +---
>  arch/arm/mm/Kconfig            | 6 ------
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/arch/arm/include/asm/barrier.h b/arch/arm/include/asm/barrier.h
> index 112cc1a..f5d6981 100644
> --- a/arch/arm/include/asm/barrier.h
> +++ b/arch/arm/include/asm/barrier.h
> @@ -44,9 +44,7 @@ extern void arm_heavy_mb(void);
>  #define __arm_heavy_mb(x...) dsb(x)
>  #endif
>
> -#ifdef CONFIG_ARCH_HAS_BARRIERS
> -#include <mach/barriers.h>
> -#elif defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
> +#if defined(CONFIG_ARM_DMA_MEM_BUFFERABLE) || defined(CONFIG_SMP)
>  #define mb()           __arm_heavy_mb()
>  #define rmb()          dsb()
>  #define wmb()          __arm_heavy_mb(st)
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index cb569b6..d15a7fe 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -1025,12 +1025,6 @@ config ARM_DMA_MEM_BUFFERABLE
>
>           You are recommended say 'Y' here and debug any affected drivers.
>
> -config ARCH_HAS_BARRIERS
> -       bool
> -       help
> -         This option allows the use of custom mandatory barriers
> -         included via the mach/barriers.h file.
> -
>  config ARM_HEAVY_MB
>         bool
>
> --
> 1.9.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Best Regards
Masahiro Yamada
