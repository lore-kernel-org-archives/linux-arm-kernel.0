From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 15 Sep 2011 22:19:09 +0200
Subject: [PATCH v2] spi/imx: Fix spi-imx when the hardware SPI
	chipselects are used
In-Reply-To: <20110915195243.GH11297@pengutronix.de>
References: <1316111337-13485-1-git-send-email-fabio.estevam@freescale.com>
	<20110915195243.GH11297@pengutronix.de>
Message-ID: <20110915201909.GI11297@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Thu, Sep 15, 2011 at 09:52:43PM +0200, Uwe Kleine-K?nig wrote:
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 8ac6542..fa594d6 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -786,9 +786,11 @@ static int __devinit spi_imx_probe(struct platform_device *pdev)
>  		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
>  		if (cs_gpio < 0)
>  			cs_gpio = mxc_platform_info->chipselect[i];
> +
> +		spi_imx->chipselect[i] = cs_gpio;
>  		if (cs_gpio < 0)
>  			continue;
> -		spi_imx->chipselect[i] = cs_gpio;
> +
>  		ret = gpio_request(spi_imx->chipselect[i], DRIVER_NAME);
>  		if (ret) {
>  			while (i > 0) {
Having said that I wonder how to specify to use an internal chipselect
via DT?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
