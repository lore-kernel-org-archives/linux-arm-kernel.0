From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 5 Oct 2009 14:19:36 +0200
Subject: [PATCH] fix pcm037_eet compilation with the new SPI driver
In-Reply-To: <Pine.LNX.4.64.0910051001500.4337@axis700.grange>
References: <Pine.LNX.4.64.0910051001500.4337@axis700.grange>
Message-ID: <20091005121936.GD23986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Mon, Oct 05, 2009 at 10:04:51AM +0200, Guennadi Liakhovetski wrote:
> At some point the SPI device name in arch/arm/mach-mx3/devices.c has 
> changed, which then broke compilation of pcm037_eet with the new SPI 
> driver. Use the correct name.

It didn't change, it was merged with imx_spi_device0. Can we change the
name in devices.[ch] instead? All other devices start with mxc_. Sorry,
my bad.

Sascha


> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> diff --git a/arch/arm/mach-mx3/pcm037_eet.c b/arch/arm/mach-mx3/pcm037_eet.c
> index 8d38600..dc6baf3 100644
> --- a/arch/arm/mach-mx3/pcm037_eet.c
> +++ b/arch/arm/mach-mx3/pcm037_eet.c
> @@ -184,7 +184,7 @@ static int eet_init_devices(void)
>  	/* SPI */
>  	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
>  #if defined(CONFIG_SPI_IMX) || defined(CONFIG_SPI_IMX_MODULE)
> -	mxc_register_device(&mxc_spi_device0, &pcm037_spi1_master);
> +	mxc_register_device(&imx_spi_device0, &pcm037_spi1_master);
>  #endif
>  
>  	platform_device_register(&pcm037_gpio_keys_device);
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
