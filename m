From: varkabhadram@gmail.com (Varka Bhadram)
Date: Fri, 09 Jan 2015 06:06:05 +0530
Subject: [PATCH 2/2] leds: tlc59116: Driver for the TI 16 Channel i2c
 LED driver
In-Reply-To: <1420763178-10115-3-git-send-email-andrew@lunn.ch>
References: <1420763178-10115-1-git-send-email-andrew@lunn.ch>
 <1420763178-10115-3-git-send-email-andrew@lunn.ch>
Message-ID: <54AF2275.9050600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Friday 09 January 2015 05:56 AM, Andrew Lunn wrote:
> The TLC59116 is an I2C bus controlled 16-channel LED driver.  Each LED
> output has its own 8-bit fixed-frequency PWM controller to control the
> brightness of the LED.
>
> This is based on a driver from Belkin, but has been extensively
> rewritten.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Cc: Matthew.Fatheree at belkin.com
> ---
>   drivers/leds/Kconfig         |   7 ++
>   drivers/leds/Makefile        |   1 +
>   drivers/leds/leds-tlc59116.c | 253 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 261 insertions(+)
>   create mode 100644 drivers/leds/leds-tlc59116.c
>
(...)

> +static const struct of_device_id of_tlc59116_leds_match[] = {
> +	{ .compatible = "ti,tlc59116", },
> +	{},
> +};
> +

Missing MODULE_DEVICE_TABLE(of, ...)..?

> +static const struct i2c_device_id tlc59116_id[] = {
> +	{ "tlc59116" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, tlc59116_id);
> +
> +static struct i2c_driver tlc59116_driver = {
> +	.driver = {
> +		.name = "tlc59116",
> +		.of_match_table = of_match_ptr(of_tlc59116_leds_match),
> +

Remove this unnecessary line space...

> +	},
> +	.probe = tlc59116_probe,
> +	.remove = tlc59116_remove,
> +	.id_table = tlc59116_id,
> +};
> +
> +module_i2c_driver(tlc59116_driver);
> +
> +MODULE_AUTHOR("Andrew Lunn <andrew@lunn.ch>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("TLC59116 LED driver");

-- 
Thanks and Regards,
Varka Bhadram.
