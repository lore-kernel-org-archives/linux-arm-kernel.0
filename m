From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 05 Apr 2013 00:30:30 +0200
Subject: [PATCH 1/9] ARM: cpuidle: remove useless declaration
In-Reply-To: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <2872594.RzEdba6jp9@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 03, 2013 02:15:14 PM Daniel Lezcano wrote:
> The noop functions code is not necessary because the header file is
> included in files which are compiled when CONFIG_CPU_IDLE is on.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I need an ACK for this one.

Thanks,
Rafael


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
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
