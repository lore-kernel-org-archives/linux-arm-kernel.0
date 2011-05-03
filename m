From: philipp.zabel@gmail.com (Philipp Zabel)
Date: Tue, 03 May 2011 12:15:56 +0200
Subject: [PATCH] pxa/hx4700: Add ASIC3 LED support
In-Reply-To: <E1QGESE-0007gF-VJ@outmx08.plus.net>
References: <E1QGESE-0007gF-VJ@outmx08.plus.net>
Message-ID: <1304417758.13769.1.camel@flow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, den 30.04.2011, 17:59 +0000 schrieb Paul Parsons:
> Add LED support for the HTC ASIC3. Underlying support is provided by the mfd/asic3 and leds/leds-asic3 drivers. An example configuration is provided by the pxa/hx4700 platform.
> 
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> diff -uprN clean-2.6.39-rc5/arch/arm/mach-pxa/hx4700.c linux-2.6.39-rc5/arch/arm/mach-pxa/hx4700.c
> --- clean-2.6.39-rc5/arch/arm/mach-pxa/hx4700.c	2011-04-28 11:18:09.310551240 +0100
> +++ linux-2.6.39-rc5/arch/arm/mach-pxa/hx4700.c	2011-04-30 15:52:19.956069045 +0100
> @@ -23,6 +23,7 @@
>  #include <linux/gpio_keys.h>
>  #include <linux/input.h>
>  #include <linux/lcd.h>
> +#include <linux/leds.h>

This is not needed anymore.

>  #include <linux/mfd/htc-egpio.h>
>  #include <linux/mfd/asic3.h>
>  #include <linux/mtd/physmap.h>
> @@ -280,6 +281,21 @@ static u16 asic3_gpio_config[] = {
>  	ASIC3_GPIOD15_nPIOW,
>  };
>  
> +static struct asic3_led asic3_leds[ASIC3_NUM_LEDS] = {
> +	[0] = {
> +		.name = "hx4700:amber",
> +		.default_trigger = "ds2760-battery.0-charging-blink-full-solid",
> +	},
> +	[1] = {
> +		.name = "hx4700:green",
> +		.default_trigger = "unused",
> +	},
> +	[2] = {
> +		.name = "hx4700:blue",
> +		.default_trigger = "hx4700-radio",
> +	},
> +};
> +
>  static struct resource asic3_resources[] = {
>  	/* GPIO part */
>  	[0] = {
> @@ -310,6 +326,7 @@ static struct asic3_platform_data asic3_
>  	.gpio_config_num = ARRAY_SIZE(asic3_gpio_config),
>  	.irq_base        = IRQ_BOARD_START,
>  	.gpio_base       = HX4700_ASIC3_GPIO_BASE,
> +	.leds            = asic3_leds,
>  };
>  
>  static struct platform_device asic3 = {

After removal of the superfluous include,
Acked-by: Philipp Zabel <philipp.zabel@gmail.com>

regards
Philipp
