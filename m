From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Feb 2014 18:01:16 +0000
Subject: [PATCH 02/22] arm: add new asm macro update_sctlr
In-Reply-To: <1391619853-10601-3-git-send-email-leif.lindholm@linaro.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140205180115.GE28140@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 05, 2014 at 05:03:53PM +0000, Leif Lindholm wrote:
> A new macro for setting/clearing bits in the SCTLR.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/assembler.h |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Will Deacon <will.deacon@arm.com>

(although really minor comment below)

> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 5c22851..e8ca24b 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -383,4 +383,18 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  #endif
>  	.endm
>  
> +#ifdef CONFIG_CPU_CP15
> +/* Macro for setting/clearing bits in sctlr */
> +	.macro	update_sctlr, tmp:req, set=, clear=
> +	mrc	p15, 0, \tmp, c1, c0, 0
> +	.ifnc	\set,
> +	orr	\tmp, \set

I'd prefer the 3-arg form here for consistency (with this macro and the
rest of the file).

Will
