From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 6 Dec 2012 08:42:15 +0100
Subject: [PATCH] pwm: i.MX: eliminate build warning
In-Reply-To: <1354721681-31843-1-git-send-email-LW@KARO-electronics.de>
References: <1354721681-31843-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20121206074215.GS10369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 05, 2012 at 04:34:41PM +0100, Lothar Wa?mann wrote:
> compiling the i.MX pwm driver produces the following warning:
> |drivers/pwm/pwm-imx.c: In function 'imx_pwm_probe':
> |drivers/pwm/pwm-imx.c:281:7: warning: assignment discards qualifiers from pointer target type
> 
> Apply a 'const' attribute to the affected variable declaration.
> 
> Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Sascha

> ---
>  drivers/pwm/pwm-imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
> index 8f26e9f..65a86bd 100644
> --- a/drivers/pwm/pwm-imx.c
> +++ b/drivers/pwm/pwm-imx.c
> @@ -235,7 +235,7 @@ static int imx_pwm_probe(struct platform_device *pdev)
>  {
>  	const struct of_device_id *of_id =
>  			of_match_device(imx_pwm_dt_ids, &pdev->dev);
> -	struct imx_pwm_data *data;
> +	const struct imx_pwm_data *data;
>  	struct imx_chip *imx;
>  	struct resource *r;
>  	int ret = 0;
> -- 
> 1.7.2.5
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
