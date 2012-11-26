From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 26 Nov 2012 10:08:14 +0100
Subject: [PATCH 2/4] ds1374: add support of device tree
In-Reply-To: <1353874625-14754-3-git-send-email-tremyfr@yahoo.fr>
References: <1353874625-14754-1-git-send-email-tremyfr@yahoo.fr>
 <1353874625-14754-3-git-send-email-tremyfr@yahoo.fr>
Message-ID: <20121126100814.1459e3d7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Philippe Reynes,

On Sun, 25 Nov 2012 21:17:03 +0100, Philippe Reynes wrote:
> Signed-off-by: Philippe Reynes <tremyfr@yahoo.fr>
> ---
>  drivers/rtc/rtc-ds1374.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1374.c b/drivers/rtc/rtc-ds1374.c
> index 9663160..174c532 100644
> --- a/drivers/rtc/rtc-ds1374.c
> +++ b/drivers/rtc/rtc-ds1374.c
> @@ -49,6 +49,14 @@ static const struct i2c_device_id ds1374_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ds1374_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id ds1374_of_match[] __devinitconst = {
> +	{ .compatible = "dallas,ds1374" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ds1374_of_match);
> +#endif
> +

Don't we need a Device Tree binding documentation in
Documentation/devicetree/bindings/rtc/ ?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
