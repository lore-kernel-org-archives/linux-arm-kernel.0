From: Wenyou.Yang@microchip.com (Wenyou.Yang at microchip.com)
Date: Wed, 29 Mar 2017 04:55:17 +0000
Subject: [PATCH v2 10/11] ARM: at91: pm: Remove at91_pm_set_standby
In-Reply-To: <20170328111938.21297-11-alexandre.belloni@free-electrons.com>
References: <20170328111938.21297-1-alexandre.belloni@free-electrons.com>
 <20170328111938.21297-11-alexandre.belloni@free-electrons.com>
Message-ID: <F9F4555C4E01D7469D37975B62D0EFBB51D7F7@CHN-SV-EXMX07.mchp-main.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2017?3?28? 19:20
> To: Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Boris
> Brezillon <boris.brezillon@free-electrons.com>; Wenyou Yang - A41535
> <Wenyou.Yang@microchip.com>; Alexandre Belloni <alexandre.belloni@free-
> electrons.com>
> Subject: [PATCH v2 10/11] ARM: at91: pm: Remove at91_pm_set_standby
> 
> Merge at91_pm_set_standby() in at91_dt_ramc as this is the only callsite.
> That moves it to the init section.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Wenyou Yang <wenyou.yang@atmel.com>

> ---
>  arch/arm/mach-at91/pm.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c index
> dedfe9038336..2cd27c830ab6 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -205,12 +205,6 @@ static struct platform_device at91_cpuidle_device = {
>  	.name = "cpuidle-at91",
>  };
> 
> -static void at91_pm_set_standby(void (*at91_standby)(void)) -{
> -	if (at91_standby)
> -		at91_cpuidle_device.dev.platform_data = at91_standby;
> -}
> -
>  /*
>   * The AT91RM9200 goes into self-refresh mode with this command, and will
>   * terminate self-refresh automatically on the next SDRAM access.
> @@ -354,7 +348,7 @@ static __init void at91_dt_ramc(void)
>  	struct device_node *np;
>  	const struct of_device_id *of_id;
>  	int idx = 0;
> -	const void *standby = NULL;
> +	void *standby = NULL;
>  	const struct ramc_info *ramc;
> 
>  	for_each_matching_node_and_match(np, ramc_ids, &of_id) { @@ -378,7
> +372,7 @@ static __init void at91_dt_ramc(void)
>  		return;
>  	}
> 
> -	at91_pm_set_standby(standby);
> +	at91_cpuidle_device.dev.platform_data = standby;
>  }
> 
>  static void at91rm9200_idle(void)
> --
> 2.11.0

Best Regards,
Wenyou Yang
