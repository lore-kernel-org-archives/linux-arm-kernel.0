From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 6 Aug 2018 11:17:57 +0200
Subject: [PATCH RESEND 4/5] spi: imx: remove unnecessary check in
 spi_imx_can_dma
In-Reply-To: <20180717143154.28241-5-maxime.chevallier@bootlin.com>
References: <20180717143154.28241-1-maxime.chevallier@bootlin.com>
 <20180717143154.28241-5-maxime.chevallier@bootlin.com>
Message-ID: <20180806091757.fnbonh66kd2cuuyk@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 04:31:53PM +0200, Maxime Chevallier wrote:
> The spi_imx_can_dma function computes the watermark level so that
> the transfer will fit in exactly N bursts (without a remainder).
> 
> The smallest watermark level possible being one FIFO entry per burst, we
> can't never have a case where the transfer size isn't divsiible by 1.

s/can't never/can never/
s/divsiible/divisible/

Otherwise:

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> 
> Remove the extra check for the wml being different than 0.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/spi/spi-imx.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 3ae706dac660..ef6d3648396a 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -229,9 +229,6 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
>  			break;
>  	}
>  
> -	if (i == 0)
> -		return false;
> -
>  	spi_imx->wml = i;
>  	spi_imx->dynamic_burst = 0;
>  
> -- 
> 2.11.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
