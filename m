From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 10:06:49 +0800
Subject: [PATCH] serial/imx: propagate error from of_alias_get_id instead
 of using -ENODEV
In-Reply-To: <1323894411-12294-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1323894411-12294-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20111215020648.GC3259@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:26:51PM +0100, Uwe Kleine-K?nig wrote:
> A quick look at of_alias_get_id shows that in the error case it returns
> -ENODEV, too, but still it's better style to propagate the value as is.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
> Cc: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Acked-by: Shawn Guo <shawn.guo@linaro.org>

The only errno that of_alias_get_id could return is also -ENODEV though.

Regards,
Shawn

>  drivers/tty/serial/imx.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 163fc90..75c159a 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1301,7 +1301,7 @@ static int serial_imx_probe_dt(struct imx_port *sport,
>  	ret = of_alias_get_id(np, "serial");
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
> -		return -ENODEV;
> +		return ret;
>  	}
>  	sport->port.line = ret;
>  
> -- 
> 1.7.7.3
