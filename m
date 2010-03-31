From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 31 Mar 2010 02:16:54 +0100
Subject: [PATCH v2 1/3] ARM: S5P6440: Bug fix on PWM Timer
In-Reply-To: <1268980392-2497-1-git-send-email-kgene.kim@samsung.com>
References: <1268980392-2497-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100331011654.GO31126@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 19, 2010 at 03:33:12PM +0900, Kukjin Kim wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
> 
> This patch fixes return value in below functions

I'll look at merging fixes in the next few days.

> - pwm_cfg_src_is_tclk
> - tcfg_to_divisor
> - pwm_tdiv_has_div1
> - pwm_tdiv_div_bits
> 
> And this patch changes Copyright ordering, and addes 'based on' information.
> 
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-s5p6440/include/mach/pwm-clock.h |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-s5p6440/include/mach/pwm-clock.h b/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
> index c4bb7c5..6a2a02f 100644
> --- a/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
> +++ b/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
> @@ -1,11 +1,14 @@
>  /* linux/arch/arm/mach-s5p6440/include/mach/pwm-clock.h
>   *
> + * Copyright (c) 2009 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com/
> + *
> + * Copyright 2008 Openmoko, Inc.
>   * Copyright 2008 Simtec Electronics
>   *      Ben Dooks <ben@simtec.co.uk>
>   *      http://armlinux.simtec.co.uk/
>   *
> - * Copyright 2009 Samsung Electronics Co., Ltd.
> - *		http://www.samsung.com/
> + * Based on arch/arm/mach-s3c64xx/include/mach/pwm-clock.h
>   *
>   * S5P6440 - pwm clock and timer support
>   *
> @@ -14,16 +17,19 @@
>   * published by the Free Software Foundation.
>  */
>  
> +#ifndef __ASM_ARCH_PWMCLK_H
> +#define __ASM_ARCH_PWMCLK_H __FILE__
> +
>  /**
>   * pwm_cfg_src_is_tclk() - return whether the given mux config is a tclk
> - * @cfg: The timer TCFG1 register bits shifted down to 0.
> + * @tcfg: The timer TCFG1 register bits shifted down to 0.
>   *
>   * Return true if the given configuration from TCFG1 is a TCLK instead
>   * any of the TDIV clocks.
>   */
>  static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
>  {
> -	return tcfg == S3C2410_TCFG1_MUX_TCLK;
> +	return 0;
>  }
>  
>  /**
> @@ -35,7 +41,7 @@ static inline int pwm_cfg_src_is_tclk(unsigned long tcfg)
>   */
>  static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
>  {
> -	return 1 << (1 + tcfg1);
> +	return 1 << tcfg1;
>  }
>  
>  /**
> @@ -45,7 +51,7 @@ static inline unsigned long tcfg_to_divisor(unsigned long tcfg1)
>   */
>  static inline unsigned int pwm_tdiv_has_div1(void)
>  {
> -	return 0;
> +	return 1;
>  }
>  
>  /**
> @@ -56,7 +62,9 @@ static inline unsigned int pwm_tdiv_has_div1(void)
>   */
>  static inline unsigned long pwm_tdiv_div_bits(unsigned int div)
>  {
> -	return ilog2(div) - 1;
> +	return ilog2(div);
>  }
>  
> -#define S3C_TCFG1_MUX_TCLK S3C2410_TCFG1_MUX_TCLK
> +#define S3C_TCFG1_MUX_TCLK 0
> +
> +#endif /* __ASM_ARCH_PWMCLK_H */
> -- 
> 1.6.2.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
