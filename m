From: stefan@agner.ch (Stefan Agner)
Date: Mon, 14 Nov 2016 07:47:52 +0100
Subject: [PATCH] i.MX: Kconfig: Drop errata 769419 for Vybrid
In-Reply-To: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
References: <1478709850-9361-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <74a81a07f7c7ca999ad21da34d00b6a8@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-11-09 17:44, Andrey Smirnov wrote:
> According to the datasheet, VF610 uses revision r3p2 of the L2C-310
> block, same as i.MX6Q+, which does not require a software workaround for
> ARM errata 769419.

FWIW, r3p2 is also the revision according to the cache registers...

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan


> 
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  arch/arm/mach-imx/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 9155b63..936c59d 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -557,7 +557,6 @@ config SOC_VF610
>  	bool "Vybrid Family VF610 support"
>  	select ARM_GIC if ARCH_MULTI_V7
>  	select PINCTRL_VF610
> -	select PL310_ERRATA_769419 if CACHE_L2X0
>  
>  	help
>  	  This enables support for Freescale Vybrid VF610 processor.
