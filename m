From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 22 Feb 2016 13:43:39 +0100
Subject: [PATCH v2 01/15] arm: use of_platform_default_populate() to
 populate default bus
In-Reply-To: <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1453868872-26300-2-git-send-email-wangkefeng.wang@huawei.com>
 <1453881180-12296-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <56CB027B.6000703@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/01/2016 08:53, Kefeng Wang a ?crit :
> diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> index c1a7c6c..1904bc7 100644
> --- a/arch/arm/mach-at91/at91rm9200.c
> +++ b/arch/arm/mach-at91/at91rm9200.c
> @@ -31,7 +31,7 @@ static void __init at91rm9200_dt_device_init(void)
>  	if (soc != NULL)
>  		soc_dev = soc_device_to_device(soc);
>  
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
> +	of_platform_default_populate(NULL, NULL, soc_dev);
>  
>  	arm_pm_idle = at91rm9200_idle;
>  	at91rm9200_pm_init();
> diff --git a/arch/arm/mach-at91/at91sam9.c b/arch/arm/mach-at91/at91sam9.c
> index 7eb64f7..d495620 100644
> --- a/arch/arm/mach-at91/at91sam9.c
> +++ b/arch/arm/mach-at91/at91sam9.c
> @@ -61,7 +61,7 @@ static void __init at91sam9_common_init(void)
>  	if (soc != NULL)
>  		soc_dev = soc_device_to_device(soc);
>  
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
> +	of_platform_default_populate(NULL, NULL, soc_dev);
>  
>  	arm_pm_idle = at91sam9_idle;
>  }
> diff --git a/arch/arm/mach-at91/sama5.c b/arch/arm/mach-at91/sama5.c
> index d9cf679..6db395e 100644
> --- a/arch/arm/mach-at91/sama5.c
> +++ b/arch/arm/mach-at91/sama5.c
> @@ -50,7 +50,7 @@ static void __init sama5_dt_device_init(void)
>  	if (soc != NULL)
>  		soc_dev = soc_device_to_device(soc);
>  
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
> +	of_platform_default_populate(NULL, NULL, soc_dev);
>  	at91sam9x5_pm_init();
>  }

For AT91:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, bye.
-- 
Nicolas Ferre
