From: greg@kroah.com (Greg KH)
Date: Sun, 30 Jul 2017 07:50:57 -0700
Subject: [PATCH v4 5/9] serial: fsl_lpuart: Use common rs485 device tree
 parsing function
In-Reply-To: <20170718105948.21986-6-u.kleine-koenig@pengutronix.de>
References: <20170718105948.21986-1-u.kleine-koenig@pengutronix.de>
 <20170718105948.21986-6-u.kleine-koenig@pengutronix.de>
Message-ID: <20170730145057.GC18707@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 12:59:44PM +0200, Uwe Kleine-K?nig wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> We just got a common helper for parsing the rs485 specific
> device tree properties. Use it and drop the open coded parser.
> 
> As a side effect this adds support for parsing rs485-rts-delay and
> rs485-rx-during-tx. As the driver doesn't support this though, probing
> fails if these are defined.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/tty/serial/fsl_lpuart.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index 4becfbf35c4c..cac81b143abe 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2161,6 +2161,24 @@ static int lpuart_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	of_get_rs485_mode(np, &sport->port.rs485);

error checking?

Elsewhere in this series as well.

Also, why did you not cc: me on this series so I am sure to see it?

thanks,

greg k-h
