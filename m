From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 4 Mar 2015 08:35:05 +0100
Subject: [PATCH] ARM: at91: pm: change at91_pm_set_standby() to static
In-Reply-To: <1425433485-902-1-git-send-email-wenyou.yang@atmel.com>
References: <1425433485-902-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150304073505.GA3989@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2015 at 09:44:45 +0800, Wenyou Yang wrote :
> Since at91_pm_set_standby() will not be used out of the pm.c file,
> change its attribute from extern to static, remove its declaration as well.
> 
> void at91_pm_set_standby(void (*at91_standby)(void))
> -->
> static void at91_pm_set_standby(void (*at91_standby)(void))
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/mach-at91/pm.c |    2 +-
>  arch/arm/mach-at91/pm.h |    6 ------
>  2 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index aa4116e..a4473dc 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -218,7 +218,7 @@ static struct platform_device at91_cpuidle_device = {
>  	.name = "cpuidle-at91",
>  };
>  
> -void at91_pm_set_standby(void (*at91_standby)(void))
> +static void at91_pm_set_standby(void (*at91_standby)(void))
>  {
>  	if (at91_standby) {
>  		at91_cpuidle_device.dev.platform_data = at91_standby;
> diff --git a/arch/arm/mach-at91/pm.h b/arch/arm/mach-at91/pm.h
> index 86c0aa8..86a9d0b 100644
> --- a/arch/arm/mach-at91/pm.h
> +++ b/arch/arm/mach-at91/pm.h
> @@ -15,12 +15,6 @@
>  
>  #include <mach/at91_ramc.h>
>  
> -#ifdef CONFIG_PM
> -extern void at91_pm_set_standby(void (*at91_standby)(void));
> -#else
> -static inline void at91_pm_set_standby(void (*at91_standby)(void)) { }
> -#endif
> -
>  /*
>   * The AT91RM9200 goes into self-refresh mode with this command, and will
>   * terminate self-refresh automatically on the next SDRAM access.
> -- 
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
