From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 11 Jan 2011 12:48:45 -0500 (EST)
Subject: [PATCH] bitops: remove condition code clobber for CLZ
In-Reply-To: <1294767725-14814-1-git-send-email-rabin@rab.in>
References: <1294767725-14814-1-git-send-email-rabin@rab.in>
Message-ID: <alpine.LFD.2.00.1101111247360.17086@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Jan 2011, Rabin Vincent wrote:

> The CLZ instruction does not alter the condition flags, so remove the
> "cc" clobber from the inline asm for fls().
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Acked-by: Nicolas Pitre <nicolas.pitre@linaro.org>


> ---
>  arch/arm/include/asm/bitops.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/include/asm/bitops.h b/arch/arm/include/asm/bitops.h
> index 338ff19..7b1bb2b 100644
> --- a/arch/arm/include/asm/bitops.h
> +++ b/arch/arm/include/asm/bitops.h
> @@ -285,7 +285,7 @@ static inline int fls(int x)
>  	if (__builtin_constant_p(x))
>  	       return constant_fls(x);
>  
> -	asm("clz\t%0, %1" : "=r" (ret) : "r" (x) : "cc");
> +	asm("clz\t%0, %1" : "=r" (ret) : "r" (x));
>         	ret = 32 - ret;
>  	return ret;
>  }
> -- 
> 1.7.2.3
> 
