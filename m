From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 09:41:59 +0200
Subject: [PATCH] ARM: mach-qong: Add watchdog support
In-Reply-To: <1316440786-21118-1-git-send-email-fabio.estevam@freescale.com>
References: <1316440786-21118-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110920074159.GA14191@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 10:59:46AM -0300, Fabio Estevam wrote:
> Add watchdog support for mach-qong target.

Applied to features branch.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig     |    1 +
>  arch/arm/mach-imx/mach-qong.c |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 0519dd7..8748531 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -485,6 +485,7 @@ config MACH_QONG
>  	bool "Support Dave/DENX QongEVB-LITE platform"
>  	select SOC_IMX31
>  	select IMX_HAVE_PLATFORM_IMX_UART
> +	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	help
>  	  Include support for Dave/DENX QongEVB-LITE platform. This includes
>  	  specific configurations for the board and its peripherals.
> diff --git a/arch/arm/mach-imx/mach-qong.c b/arch/arm/mach-imx/mach-qong.c
> index 3626f48..44462ce 100644
> --- a/arch/arm/mach-imx/mach-qong.c
> +++ b/arch/arm/mach-imx/mach-qong.c
> @@ -249,6 +249,7 @@ static void __init qong_init(void)
>  	mxc_init_imx_uart();
>  	qong_init_nor_mtd();
>  	qong_init_fpga();
> +	imx31_add_imx2_wdt(NULL);
>  }
>  
>  static void __init qong_timer_init(void)
> -- 
> 1.6.0.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
