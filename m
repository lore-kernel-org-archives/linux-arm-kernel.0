From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 23 May 2014 10:43:59 +0200
Subject: [PATCH v2] pwm: imx: set can_sleep flag for imx_pwm
In-Reply-To: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
References: <1400834488-2660-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20140523084359.GD20155@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 04:41:28PM +0800, Shawn Guo wrote:
> The .config() hook imx_pwm_config() calls clk APIs like clk_prepare()
> and clk_get_rate(), which might sleep, so we need to set can_sleep flag
> on pwm_chip.
Wasn't there a bug that was fixed or at least made more obvious with
this change? Is it worth mentioning in the commit log?

Otherwise
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Uwe
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
> Changes since v1:
>  - Set can_sleep flag for both imx_pwm_v1 and imx_pwm_v2
> 
>  drivers/pwm/pwm-imx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index d797c7b84c3f..5449d9150d40 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -262,6 +262,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  	imx->chip.dev = &pdev->dev;
>  	imx->chip.base = -1;
>  	imx->chip.npwm = 1;
> +	imx->chip.can_sleep = true;
>  
>  	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	imx->mmio_base = devm_ioremap_resource(&pdev->dev, r);
> -- 
> 1.8.3.2
> 
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
