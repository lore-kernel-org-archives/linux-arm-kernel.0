From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Sat, 22 Jun 2013 07:09:12 +0200
Subject: [PATCH] ARM: imx: Synertronixx scb9328 needs to select SOC_IMX1
In-Reply-To: <2223651.9m9to5aFxT@wuerfel>
References: <2223651.9m9to5aFxT@wuerfel>
Message-ID: <20130622050912.GH32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 22, 2013 at 01:29:12AM +0200, Arnd Bergmann wrote:
> This is required for building a kernel that enables only
> scb9328 and would not get the i.MX1 specific files
> otherwise.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Sascha Hauer <kernel@pengutronix.de>

Acked-by: Sascha Hauer <kernel@pengutronix.de>

> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index eef9590..60661a4 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -173,6 +173,7 @@ config ARCH_MX1ADS
>  config MACH_SCB9328
>  	bool "Synertronixx scb9328"
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select SOC_IMX1
>  	help
>  	  Say Y here if you are using a Synertronixx scb9328 board
>  
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
