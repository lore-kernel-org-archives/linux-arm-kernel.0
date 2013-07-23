From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 23 Jul 2013 15:48:11 -0400 (EDT)
Subject: [PATCH 1/6] ARM: prefetch: remove redundant "cc" clobber
In-Reply-To: <1374579389-32704-2-git-send-email-will.deacon@arm.com>
References: <1374579389-32704-1-git-send-email-will.deacon@arm.com>
 <1374579389-32704-2-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.03.1307231547010.15022@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Jul 2013, Will Deacon wrote:

> The pld instruction does not affect the condition flags, so don't bother
> clobbering them.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

You know the legacy reason why the cc clobber was there, right?
It certainly doesn't apply anymore.



> ---
>  arch/arm/include/asm/processor.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/arm/include/asm/processor.h b/arch/arm/include/asm/processor.h
> index 06e7d50..91cfe08 100644
> --- a/arch/arm/include/asm/processor.h
> +++ b/arch/arm/include/asm/processor.h
> @@ -101,9 +101,7 @@ static inline void prefetch(const void *ptr)
>  {
>  	__asm__ __volatile__(
>  		"pld\t%a0"
> -		:
> -		: "p" (ptr)
> -		: "cc");
> +		:: "p" (ptr));
>  }
>  
>  #define ARCH_HAS_PREFETCHW
> -- 
> 1.8.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
