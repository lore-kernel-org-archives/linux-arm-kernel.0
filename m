From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Wed, 19 Aug 2015 10:02:30 +0200
Subject: [PATCH v2 06/21] ARM: pxa: magician: Add normal and power I2C
 definition
In-Reply-To: <55D2593A.5060400@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz> <55D2593A.5060400@tul.cz>
Message-ID: <1439971350.11928.28.camel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 17.08.2015, 23:59 +0200 schrieb Petr Cvek:
> Add normal and power I2C definition to HTC Magician.

What do you need i2c-gpio for? As I said before, I don't think this
should be in mainline, rather the pxa-i2c driver should be used.

>  
>  /*
> + * PXA I2C power controller
> + */
> +
> +static struct i2c_pxa_platform_data magician_i2c_power_info = {
> +	.fast_mode = 0,
> +	.use_pio = 0,
> +};
[...]
> @@ -975,7 +1009,7 @@ static void __init magician_init(void)
>  	platform_add_devices(ARRAY_AND_SIZE(devices));
>  
>  	pxa_set_ficp_info(&magician_ficp_info);
> -	pxa27x_set_i2c_power_info(NULL);
> +	pxa27x_set_i2c_power_info(&magician_i2c_power_info);

Does this actually have an effect?

regards
Philipp
