From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 8 Oct 2010 11:25:43 +0200
Subject: [PATCH v2 for 2.6.36 1/2] cpuimx27: fix compile when ULPI is
	selected
In-Reply-To: <1286527061-3013-1-git-send-email-eric@eukrea.com>
References: <1286527061-3013-1-git-send-email-eric@eukrea.com>
Message-ID: <20101008092543.GE29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 08, 2010 at 10:37:40AM +0200, Eric B?nard wrote:
> without this patch we get :
> arch/arm/mach-imx/built-in.o: In function `eukrea_cpuimx27_init':
> eukrea_mbimx27-baseboard.c:(.init.text+0x44c): undefined reference to `mxc_ulpi_access_ops'
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> v2 : remove SPI's select which leaked in previous patch
>  arch/arm/mach-imx/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index c5c0369..2f7e272 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -122,6 +122,7 @@ config MACH_CPUIMX27
>  	select IMX_HAVE_PLATFORM_IMX_I2C
>  	select IMX_HAVE_PLATFORM_IMX_UART
>  	select IMX_HAVE_PLATFORM_MXC_NAND
> +	select MXC_ULPI if USB_ULPI
>  	help
>  	  Include support for Eukrea CPUIMX27 platform. This includes
>  	  specific configurations for the module and its peripherals.
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
