From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 23 Nov 2015 11:56:57 +0100
Subject: [PATCH] drivers/reset: appropriate __init annotation for const
 data
In-Reply-To: <alpine.LFD.2.20.1511212053530.22569@knanqh.ubzr>
References: <alpine.LFD.2.20.1511212053530.22569@knanqh.ubzr>
Message-ID: <1448276217.4008.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Am Samstag, den 21.11.2015, 20:56 -0500 schrieb Nicolas Pitre:
> Init data marked const should be annotated with __initconst for
> correctness and not __initdata.  This also fixes LTO builds that
> otherwise fail with section mismatch errors.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> diff --git a/drivers/reset/reset-sunxi.c b/drivers/reset/reset-sunxi.c
> index 3d95c87160..9353b2dd15 100644
> --- a/drivers/reset/reset-sunxi.c
> +++ b/drivers/reset/reset-sunxi.c
> @@ -122,7 +122,7 @@ err_alloc:
>   * our system, before we can even think of using a regular device
>   * driver for it.
>   */
> -static const struct of_device_id sunxi_early_reset_dt_ids[] __initdata = {
> +static const struct of_device_id sunxi_early_reset_dt_ids[] __initconst = {
>  	{ .compatible = "allwinner,sun6i-a31-ahb1-reset", },
>  	{ /* sentinel */ },
>  };

Thank you for the patch, this change is already contained in the latest
pull request sent to the arm-soc maintainers.

best regards
Philipp
