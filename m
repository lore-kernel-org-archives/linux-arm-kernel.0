From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 13 Jan 2012 14:10:44 +0000
Subject: [PATCH v2 7/7] ARM: make BSYM macro assembly only
In-Reply-To: <1326389476-11569-8-git-send-email-robherring2@gmail.com>
References: <1326389476-11569-1-git-send-email-robherring2@gmail.com>
 <1326389476-11569-8-git-send-email-robherring2@gmail.com>
Message-ID: <20120113141044.GC2227@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 11:31:16AM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> BSYM macro is only needed for assembly files and its usage in c files is
> wrong, so only define it for assembly.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Dave Martin <dave.martin@linaro.org>

I already acked the previously posted version, but it's essentially the
same, so:

Acked-by: Dave Martin <dave.martin@linaro.org>

> ---
>  arch/arm/include/asm/unified.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
> index bc63116..f5989f4 100644
> --- a/arch/arm/include/asm/unified.h
> +++ b/arch/arm/include/asm/unified.h
> @@ -37,8 +37,8 @@
>  #define THUMB(x...)	x
>  #ifdef __ASSEMBLY__
>  #define W(instr)	instr.w
> -#endif
>  #define BSYM(sym)	sym + 1
> +#endif
>  
>  #else	/* !CONFIG_THUMB2_KERNEL */
>  
> @@ -49,8 +49,8 @@
>  #define THUMB(x...)
>  #ifdef __ASSEMBLY__
>  #define W(instr)	instr
> -#endif
>  #define BSYM(sym)	sym
> +#endif
>  
>  #endif	/* CONFIG_THUMB2_KERNEL */
>  
> -- 
> 1.7.5.4
> 
