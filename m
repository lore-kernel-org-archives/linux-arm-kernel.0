From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 20 Jun 2013 10:05:36 +0200
Subject: [PATCH] gpio: rcar: fix gpio_rcar_of_table
In-Reply-To: <201306191750.43755.arnd@arndb.de>
References: <201306191750.43755.arnd@arndb.de>
Message-ID: <31902772.So7m1K4hye@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Wednesday 19 June 2013 17:50:43 Arnd Bergmann wrote:
> The device table needs to be terminated with an empty element.

Oops, thanks for the patch.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> I've just added this patch on top of the arm-soc next/drivers branch
> that introduced the build warning.
> 
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 5a693dd..f332753 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -437,6 +437,7 @@ static const struct of_device_id gpio_rcar_of_table[] =
> { {
>  		.compatible = "renesas,gpio-rcar",
>  	},
> +	{ },
>  };
> 
>  MODULE_DEVICE_TABLE(of, gpio_rcar_of_table);

-- 
Regards,

Laurent Pinchart
