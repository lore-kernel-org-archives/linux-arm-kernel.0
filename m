From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 13 May 2010 12:44:52 +0100
Subject: [RFC PATCH] ARM: Allow lazy cache flushing on ARM11MPCore
In-Reply-To: <1273749756.30713.33.camel@e102109-lin.cambridge.arm.com>
References: <20100513110609.21178.39630.stgit@e102109-lin.cambridge.arm.com>
	<1273749756.30713.33.camel@e102109-lin.cambridge.arm.com>
Message-ID: <1273751092.30713.48.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-05-13 at 12:22 +0100, Catalin Marinas wrote:
> diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
> index 963a338..59303e2 100644
> --- a/arch/arm/include/asm/smp_plat.h
> +++ b/arch/arm/include/asm/smp_plat.h
> @@ -13,13 +13,4 @@ static inline int tlb_ops_need_broadcast(void)
>         return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 2;
>  }
> 
> -#if !defined(CONFIG_SMP) || __LINUX_ARM_ARCH__ >= 7
> -#define cache_ops_need_broadcast()     0
> -#else
> -static inline int cache_ops_need_broadcast(void)
> -{
> -       return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
> -}
> -#endif
> -
>  #endif

This hunk shouldn't be part of the patch since ptrace flushing still
checks for cache_ops_need_broadcast().

-- 
Catalin
