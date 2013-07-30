From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 30 Jul 2013 12:07:36 +0200
Subject: [PATCH 2/3] clocksource: Add missing dependency on CONFIG_OF
 for ARM_ARCH_TIMER
In-Reply-To: <1374682733-7416-3-git-send-email-jonathan.austin@arm.com>
References: <1374682733-7416-1-git-send-email-jonathan.austin@arm.com>
 <1374682733-7416-3-git-send-email-jonathan.austin@arm.com>
Message-ID: <51F79068.5050004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 06:18 PM, Jonathan Austin wrote:
> Initialisation of the ARM Arch timer requires data from the DT. There is no
> fallback initialisation method and hence selecting ARM_ARCH_TIMER without OF
> makes little sense.
> 
> Furthermore, doing so causes a build error because the of_* stubs for
> !CONFIG_OF do not extend to all of the functions being used by this driver,
> and will not be extended unless there are valid use-cases for them to be
> (this is not a valid case).
> 
> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
> ---

This falls under the drivers/clocksource umbrella.

Please resend to the maintainers.

Thanks
  -- Daniel

>  drivers/clocksource/Kconfig |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index b7b9b04..4348902 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -72,7 +72,8 @@ config CLKSRC_DBX500_PRCMU_SCHED_CLOCK
>  
>  config ARM_ARCH_TIMER
>  	bool
> -	select CLKSRC_OF if OF
> +	depends on OF
> +	select CLKSRC_OF
>  
>  config ARM_GLOBAL_TIMER
>  	bool
> 


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
