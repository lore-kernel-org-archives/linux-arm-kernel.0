From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Apr 2013 14:23:23 +0200
Subject: [PATCH 1/9] ARM: cpuidle: remove useless declaration
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <515C1F3B.5040008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
> The noop functions code is not necessary because the header file is
> included in files which are compiled when CONFIG_CPU_IDLE is on.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I have been involved in the development of this file. I know Rob is no
longer working on this neither monitoring the code.

Russell are you ok with this patch ? Rafael needs your ack to take this
patch into its tree.

Thanks

-- Daniel

> ---
>  arch/arm/include/asm/cpuidle.h |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/cpuidle.h
> index 2fca60a..7367787 100644
> --- a/arch/arm/include/asm/cpuidle.h
> +++ b/arch/arm/include/asm/cpuidle.h
> @@ -1,13 +1,8 @@
>  #ifndef __ASM_ARM_CPUIDLE_H
>  #define __ASM_ARM_CPUIDLE_H
>  
> -#ifdef CONFIG_CPU_IDLE
>  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index);
> -#else
> -static inline int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
> -		struct cpuidle_driver *drv, int index) { return -ENODEV; }
> -#endif
> +				    struct cpuidle_driver *drv, int index);
>  
>  /* Common ARM WFI state */
>  #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
