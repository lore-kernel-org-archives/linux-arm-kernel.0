From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Aug 2018 10:56:19 +0200
Subject: [PATCH RESEND 1/5] spi: imx: Remove duplicate variable assignments
In-Reply-To: <20180717143154.28241-2-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-2-maxime.chevallier@bootlin.com>
Message-ID: <20180806085619.zfhrow3pnkcjbjdu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 04:31:50PM +0200, Maxime Chevallier wrote:
> Some fields in struct spi_imx_data are assigned a different value twice
> in a row, in spi_imx_setupxfer.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/spi/spi-imx.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index d3b21faf6b1f..d75153c995af 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1106,8 +1106,6 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>  	if (spi_imx->devtype_data->dynamic_burst && !spi_imx->slave_mode) {
>  		u32 mask;
>  
> -		spi_imx->dynamic_burst = 0;
> -		spi_imx->remainder = 0;
>  		spi_imx->read_u32  = 1;
>  
>  		mask = (1 << spi_imx->bits_per_word) - 1;
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
