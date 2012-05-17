From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 17 May 2012 15:33:42 -0600
Subject: [PATCH 3/7] drivers/gpio: gpio-nomadik: Apply Device Tree bindings
In-Reply-To: <1334325909-5779-4-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20120517213342.41A773E0621@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Apr 2012 15:05:05 +0100, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Looks pretty good to me.  A few comments below, but otherwise you can
add my:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Does this need to be merged via the arm-soc tree?

g.

> ---
>  arch/arm/boot/dts/db8500.dtsi      |   18 +++++++++++++++
>  arch/arm/boot/dts/snowball.dts     |   10 ++++----
>  arch/arm/mach-ux500/board-mop500.c |   12 ++++++++++
>  drivers/gpio/gpio-nomadik.c        |   41 +++++++++++++++++++++++++++++++++--
>  4 files changed, 73 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
> index 421e15f..57d3d35 100644
> --- a/arch/arm/boot/dts/db8500.dtsi
> +++ b/arch/arm/boot/dts/db8500.dtsi
> @@ -61,6 +61,8 @@
>  			interrupts = <0 119 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <0>;
>  		};
>  
>  		gpio1: gpio at 8012e080 {
> @@ -70,6 +72,8 @@
>  			interrupts = <0 120 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <1>;
>  		};
>  
>  		gpio2: gpio at 8000e000 {
> @@ -79,6 +83,8 @@
>  			interrupts = <0 121 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <2>;
>  		};
>  
>  		gpio3: gpio at 8000e080 {
> @@ -88,6 +94,8 @@
>  			interrupts = <0 122 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <3>;
>  		};
>  
>  		gpio4: gpio at 8000e100 {
> @@ -97,6 +105,8 @@
>  			interrupts = <0 123 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <4>;
>  		};
>  
>  		gpio5: gpio at 8000e180 {
> @@ -106,6 +116,8 @@
>  			interrupts = <0 124 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <5>;
>  		};
>  
>  		gpio6: gpio at 8011e000 {
> @@ -115,6 +127,8 @@
>  			interrupts = <0 125 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <6>;
>  		};
>  
>  		gpio7: gpio at 8011e080 {
> @@ -124,6 +138,8 @@
>  			interrupts = <0 126 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <7>;
>  		};
>  
>  		gpio8: gpio at a03fe000 {
> @@ -133,6 +149,8 @@
>  			interrupts = <0 127 0x4>;
>  			supports-sleepmode;
>  			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-bank = <8>;
>  		};
>  
>  		usb at a03e0000 {
> diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
> index 359c6d6..738959d 100644
> --- a/arch/arm/boot/dts/snowball.dts
> +++ b/arch/arm/boot/dts/snowball.dts
> @@ -30,35 +30,35 @@
>  			wakeup = <1>;
>  			linux,code = <2>;
>  			label = "userpb";
> -			gpios = <&gpio1 0>;
> +			gpios = <&gpio1 0 0>;
>  		};
>  		button at 2 {
>  			debounce_interval = <50>;
>  			wakeup = <1>;
>  			linux,code = <3>;
>  			label = "userpb";
> -			gpios = <&gpio4 23>;
> +			gpios = <&gpio4 23 0>;
>  		};
>  		button at 3 {
>  			debounce_interval = <50>;
>  			wakeup = <1>;
>  			linux,code = <4>;
>  			label = "userpb";
> -			gpios = <&gpio4 23>;
> +			gpios = <&gpio4 24 0>;
>  		};
>  		button at 4 {
>  			debounce_interval = <50>;
>  			wakeup = <1>;
>  			linux,code = <5>;
>  			label = "userpb";
> -			gpios = <&gpio5 1>;
> +			gpios = <&gpio5 1 0>;
>  		};
>  		button at 5 {
>  			debounce_interval = <50>;
>  			wakeup = <1>;
>  			linux,code = <6>;
>  			label = "userpb";
> -			gpios = <&gpio5 2>;
> +			gpios = <&gpio5 2 0>;
>  		};
>  	};
>  
> diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
> index 77d03c1..5064140 100644
> --- a/arch/arm/mach-ux500/board-mop500.c
> +++ b/arch/arm/mach-ux500/board-mop500.c
> @@ -746,10 +746,22 @@ MACHINE_END
>  #ifdef CONFIG_MACH_UX500_DT
>  
>  struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
> +	/* Requires DMA and call-back bindings. */
>  	OF_DEV_AUXDATA("arm,pl011", 0x80120000, "uart0", &uart0_plat),
>  	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
>  	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
> +	/* Requires DMA bindings. */
>  	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
> +	/* Requires clock name bindings. */
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e000, "gpio.0", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8012e080, "gpio.1", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e000, "gpio.2", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e080, "gpio.3", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e100, "gpio.4", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8000e180, "gpio.5", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8011e000, "gpio.6", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0x8011e080, "gpio.7", NULL),
> +	OF_DEV_AUXDATA("st,nomadik-gpio", 0xa03fe000, "gpio.8", NULL),
>  	{},
>  };
>  
> diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
> index 839624f..65c7e8e 100644
> --- a/drivers/gpio/gpio-nomadik.c
> +++ b/drivers/gpio/gpio-nomadik.c
> @@ -1071,6 +1071,7 @@ void nmk_gpio_read_pull(int gpio_bank, u32 *pull_up)
>  static int __devinit nmk_gpio_probe(struct platform_device *dev)
>  {
>  	struct nmk_gpio_platform_data *pdata = dev->dev.platform_data;
> +	struct device_node *np = dev->dev.of_node;
>  	struct nmk_gpio_chip *nmk_chip;
>  	struct gpio_chip *chip;
>  	struct resource *res;
> @@ -1079,8 +1080,28 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>  	int irq;
>  	int ret;
>  
> -	if (!pdata)
> +	if (!pdata && !np) {
> +		dev_err(&dev->dev, "No platform data or device tree found\n");
>  		return -ENODEV;
> +	}
> +
> +	if (np) {
> +		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);

devm_kzalloc()

> +		if (!pdata)
> +			return -ENOMEM;
> +
> +		if (of_get_property(np, "supports-sleepmode", NULL))
> +			pdata->supports_sleepmode = true;

I believe these properties were going to be updated to add an
"stericsson," prefix.

> +
> +		if (of_property_read_u32(np, "gpio-bank", &dev->id)) {
> +			dev_err(&dev->dev, "gpio-bank property not found\n");
> +			ret = -EINVAL;
> +			goto out_dt;
> +		}
> +
> +		pdata->first_gpio = dev->id * NMK_GPIO_PER_CHIP;
> +		pdata->num_gpio   = NMK_GPIO_PER_CHIP;
> +	}
>  
>  	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
>  	if (!res) {
> @@ -1117,6 +1138,7 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>  		ret = -ENOMEM;
>  		goto out_clk;
>  	}
> +

Nit: unrelated whitespace change.

>  	/*
>  	 * The virt address in nmk_chip->addr is in the nomadik register space,
>  	 * so we can simply convert the resource address, without remapping
> @@ -1139,6 +1161,8 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>  	chip->dev = &dev->dev;
>  	chip->owner = THIS_MODULE;
>  
> +	chip->of_node = np;
> +
>  	ret = gpiochip_add(&nmk_chip->chip);
>  	if (ret)
>  		goto out_free;
> @@ -1146,12 +1170,13 @@ static int __devinit nmk_gpio_probe(struct platform_device *dev)
>  	BUG_ON(nmk_chip->bank >= ARRAY_SIZE(nmk_gpio_chips));
>  
>  	nmk_gpio_chips[nmk_chip->bank] = nmk_chip;
> +
>  	platform_set_drvdata(dev, nmk_chip);
>  
>  	nmk_gpio_init_irq(nmk_chip);
>  
> -	dev_info(&dev->dev, "at address %p\n",
> -		 nmk_chip->addr);
> +	dev_info(&dev->dev, "at address %p\n", nmk_chip->addr);
> +

Nit: unrelated change

>  	return 0;
>  
>  out_free:
> @@ -1164,13 +1189,23 @@ out_release:
>  out:
>  	dev_err(&dev->dev, "Failure %i for GPIO %i-%i\n", ret,
>  		  pdata->first_gpio, pdata->first_gpio+31);
> +out_dt:
> +	if (np)
> +		kfree(pdata);
> +
>  	return ret;
>  }
>  
> +static const struct of_device_id nmk_gpio_match[] = {
> +	{ .compatible = "st,nomadik-gpio", },
> +	{}
> +};
> +
>  static struct platform_driver nmk_gpio_driver = {
>  	.driver = {
>  		.owner = THIS_MODULE,
>  		.name = "gpio",
> +		.of_match_table = nmk_gpio_match,
>  	},
>  	.probe = nmk_gpio_probe,
>  };
> -- 
> 1.7.9.1
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
