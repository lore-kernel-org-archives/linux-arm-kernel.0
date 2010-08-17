From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 17 Aug 2010 21:31:57 +0200
Subject: [PATCH] watchdog: Enable NXP LPC32XX support in Kconfig
In-Reply-To: <AANLkTi=AiByTGvvvN_LACKLjW3TG6T2kmwKofpMmRdmz@mail.gmail.com>
References: <AANLkTi=AiByTGvvvN_LACKLjW3TG6T2kmwKofpMmRdmz@mail.gmail.com>
Message-ID: <083DF309106F364B939360100EC290F80ACF617DC8@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's been a few weeks since I've posted this.
Have I placed this in the correct mailing list?

> 
> The NXP LPC32XX processor use the same watchdog as the Philips
> PNX4008 processor.
> 
> Signed-off-by: Kevin Wells <wellsk40@gmail.com>
> ---
>  drivers/watchdog/Kconfig |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index b04b184..c442b2a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -206,11 +206,11 @@ config OMAP_WATCHDOG
>  	  here to enable the OMAP1610/OMAP1710/OMAP2420/OMAP3430/OMAP4430
> watchdog timer.
> 
>  config PNX4008_WATCHDOG
> -	tristate "PNX4008 Watchdog"
> -	depends on ARCH_PNX4008
> +	tristate "PNX4008 and LPC32XX Watchdog"
> +	depends on ARCH_PNX4008 || ARCH_LPC32XX
>  	help
>  	  Say Y here if to include support for the watchdog timer
> -	  in the PNX4008 processor.
> +	  in the PNX4008 or LPC32XX processors.
>  	  This driver can be built as a module by choosing M. The module
>  	  will be called pnx4008_wdt.
> 
> --
> 1.7.1.1
