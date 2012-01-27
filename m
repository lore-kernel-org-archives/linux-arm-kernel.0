From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 27 Jan 2012 13:37:01 -0500 (EST)
Subject: [PATCH] ARM: kuser: consistently use usr_ret for returning from
 helpers
In-Reply-To: <1327678432-15345-1-git-send-email-will.deacon@arm.com>
References: <1327678432-15345-1-git-send-email-will.deacon@arm.com>
Message-ID: <alpine.LFD.2.02.1201271335590.2759@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jan 2012, Will Deacon wrote:

> __kuser_cmpxchg64 has a return path using bx lr to get back to the caller.
> This is actually ok since the code in question is predicated on
> CONFIG_CPU_32v6K, but for the sake of consistency using the usr_ret
> macro is probably better.

Indeed.

> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Dave Martin <dave.martin@linaro.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/kernel/entry-armv.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
> index 3a456c6..be16a48 100644
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -790,7 +790,7 @@ __kuser_cmpxchg64:				@ 0xffff0f60
>  	smp_dmb	arm
>  	rsbs	r0, r3, #0			@ set returned val and C flag
>  	ldmfd	sp!, {r4, r5, r6, r7}
> -	bx	lr
> +	usr_ret	lr
>  
>  #elif !defined(CONFIG_SMP)
>  
> -- 
> 1.7.4.1
> 
