From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Tue, 28 Aug 2012 17:10:00 +0200
Subject: [PATCH v11 3/4] drivers/i2c/busses/i2c-at91.c: add new driver
In-Reply-To: <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
References: <cover.1345618760.git.n.voss@weinmann.de>
 <4f3dcfbf1e8eab3e251ab3558e9e1e9123643928.1345618760.git.n.voss@weinmann.de>
Message-ID: <503CDF48.5080201@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nikolaus,

I forgot one correction I did in your patch:

Le 11/08/2011 11:49 AM, Nikolaus Voss a ?crit :
[...]

> diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
> index 9295e90..27fddc1 100644
> --- a/arch/arm/mach-at91/at91sam9261_devices.c
> +++ b/arch/arm/mach-at91/at91sam9261_devices.c
> @@ -283,9 +283,18 @@ static struct i2c_gpio_platform_data pdata = {
>   	.udelay			= 2,		/* ~100 kHz */
>   };
>
> +static const struct platform_device_id twi_ip_type = {
> +	/*
> +	 * driver_data is 2 for SAM9261 compatible ip, see enum twi_ip_id in
> +	 * drivers/i2c/busses/i2c-at91.c
> +	 */
> +	.driver_data	= 2,
> +};
> +
>   static struct platform_device at91sam9261_twi_device = {
>   	.name			= "i2c-gpio",
>   	.id			= -1,
> +	.id_entry		= &twi_ip_type,
>   	.dev.platform_data	= &pdata,
>   };
>

[...]

You add the id_entry to the i2c-gpio device instead of at91_i2c device.

Regards

Ludovic
