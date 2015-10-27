From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Oct 2015 16:42:13 +0000
Subject: [PATCH 2/2] arm64: cachetype: fix definitions of ICACHEF_* flags
In-Reply-To: <1445947555-2109-2-git-send-email-will.deacon@arm.com>
References: <1445947555-2109-1-git-send-email-will.deacon@arm.com>
 <1445947555-2109-2-git-send-email-will.deacon@arm.com>
Message-ID: <20151027164213.GL3091@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 12:05:55PM +0000, Will Deacon wrote:
> test_bit and set_bit take the bit number to operate on, rather than a
> mask. This patch fixes the ICACHEF_* definitions so that they represent
> the bit index in __icache_flags as opposed to the mask returned by the
> BIT macro.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

At least they were used consistently, so this is a cleanup rather than a
fix.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/cachetype.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cachetype.h b/arch/arm64/include/asm/cachetype.h
> index da2fc9e3cedd..f5588692f1d4 100644
> --- a/arch/arm64/include/asm/cachetype.h
> +++ b/arch/arm64/include/asm/cachetype.h
> @@ -34,8 +34,8 @@
>  
>  #define CTR_L1IP(ctr)	(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
>  
> -#define ICACHEF_ALIASING	BIT(0)
> -#define ICACHEF_AIVIVT		BIT(1)
> +#define ICACHEF_ALIASING	0
> +#define ICACHEF_AIVIVT		1
>  
>  extern unsigned long __icache_flags;
>  
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
