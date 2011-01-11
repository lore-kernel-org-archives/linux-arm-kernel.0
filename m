From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 11 Jan 2011 10:06:43 +0100
Subject: [PATCH 1/3] ARM i.MX SPI driver changes for i.MX53 support
In-Reply-To: <1294661334-7826-1-git-send-email-yong.shen@freescale.com>
References: <1294661334-7826-1-git-send-email-yong.shen@freescale.com>
Message-ID: <20110111090643.GN12078@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 08:08:52PM +0800, yong.shen at freescale.com wrote:
> From: Yong Shen <yong.shen@freescale.com>
> 
> 1. Change the Kconfig to include i.MX53
> 2. add devtype entry for i.MX53
> 
> Signed-off-by: Yong Shen <yong.shen@freescale.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

You should send this to the spi-devel list.

Sascha

> ---
>  drivers/spi/Kconfig   |    4 ++--
>  drivers/spi/spi_imx.c |    6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 78f9fd0..04965e2 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -153,10 +153,10 @@ config SPI_IMX_VER_0_4
>  	def_bool y if ARCH_MX31
>  
>  config SPI_IMX_VER_0_7
> -	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51
> +	def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARCH_MX53
>  
>  config SPI_IMX_VER_2_3
> -	def_bool y if ARCH_MX51
> +	def_bool y if ARCH_MX51 || ARCH_MX53
>  
>  config SPI_IMX
>  	tristate "Freescale i.MX SPI controllers"
> diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> index 55a38e2..9b8a733 100644
> --- a/drivers/spi/spi_imx.c
> +++ b/drivers/spi/spi_imx.c
> @@ -747,6 +747,12 @@ static struct platform_device_id spi_imx_devtype[] = {
>  		.name = "imx51-ecspi",
>  		.driver_data = SPI_IMX_VER_2_3,
>  	}, {
> +		.name = "imx53-cspi",
> +		.driver_data = SPI_IMX_VER_0_7,
> +	}, {
> +		.name = "imx53-ecspi",
> +		.driver_data = SPI_IMX_VER_2_3,
> +	}, {
>  		/* sentinel */
>  	}
>  };
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
