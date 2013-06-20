From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Jun 2013 09:50:17 +0900
Subject: [PATCH] gpio: rcar: fix gpio_rcar_of_table
In-Reply-To: <201306191750.43755.arnd@arndb.de>
References: <201306191750.43755.arnd@arndb.de>
Message-ID: <20130620005017.GA20643@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 05:50:43PM +0200, Arnd Bergmann wrote:
> The device table needs to be terminated with an empty element.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> ---
> I've just added this patch on top of the arm-soc next/drivers branch
> that introduced the build warning.

Thanks, have you pushed it there or do I need to add it and
send a pull-request?

> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 5a693dd..f332753 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -437,6 +437,7 @@ static const struct of_device_id gpio_rcar_of_table[] = {
>  	{
>  		.compatible = "renesas,gpio-rcar",
>  	},
> +	{ },
>  };
>  
>  MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);
> 
