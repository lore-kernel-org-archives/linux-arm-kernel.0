From: marc@cpdesign.com.au (Marc Reilly)
Date: Fri, 23 Mar 2012 12:23:09 +1100
Subject: [PATCH] regulator: i.MX35-PDK Add regulator support
In-Reply-To: <1332460334-11173-1-git-send-email-alexg@meprolight.com>
References: <1332460334-11173-1-git-send-email-alexg@meprolight.com>
Message-ID: <201203231223.10043.marc@cpdesign.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm not very experienced with the regulator driver, but noticed a couple of 
minor things with your patch..

<snip>

> 
>  static const struct imxuart_platform_data uart_pdata __initconst = {
> @@ -55,7 +58,7 @@ static struct physmap_flash_data mx35pdk_flash_data = {
> 
>  static struct resource mx35pdk_flash_resource = {
>  	.start	= MX35_CS0_BASE_ADDR,
> -	.end	= MX35_CS0_BASE_ADDR + SZ_64M - 1,
> +	.end    = MX35_CS0_BASE_ADDR + SZ_64M - 1,

did you mean to change this?

>  	.flags	= IORESOURCE_MEM,
>  };
> 
> @@ -120,8 +123,214 @@ static iomux_v3_cfg_t mx35pdk_pads[] = {
>  	/* I2C1 */
>  	MX35_PAD_I2C1_CLK__I2C1_SCL,
>  	MX35_PAD_I2C1_DAT__I2C1_SDA,
> +	/*PMIC IRQ*/
> +	MX35_PAD_GPIO2_0__GPIO2_0,
>  };
> 
> +static struct regulator_init_data sw1_init = {
> +	.constraints = {
> +		.name = "SW1",
> +		.min_uV = 600000,
> +		.max_uV = 1375000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.valid_modes_mask = 0,
> +		.always_on = 1,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data sw2_init = {
> +	.constraints = {
> +		.name = "SW2",
> +		.min_uV = 900000,
> +		.max_uV = 1850000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.always_on = 1,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data sw3_init = {
> +	.constraints = {
> +		.name = "SW3",
> +		.min_uV = 1100000,
> +		.max_uV = 1850000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.always_on = 1,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data sw4_init = {
> +	.constraints = {
> +		.name = "SW4",
> +		.min_uV = 1100000,
> +		.max_uV = 1850000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.always_on = 1,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data viohi_init = {
> +	.constraints = {
> +		.name = "VIOHI",
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data vusb_init = {
> +	.constraints = {
> +		.name = "VUSB",
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data vdig_init = {
> +	.constraints = {
> +		.name = "VDIG",
> +		.min_uV = 1050000,
> +		.max_uV = 1800000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data vpll_init = {
> +	.constraints = {
> +		.name = "VPLL",
> +		.min_uV = 1050000,
> +		.max_uV = 1800000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data vusb2_init = {
> +	.constraints = {
> +		.name = "VUSB2",
> +		.min_uV = 2400000,
> +		.max_uV = 2775000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.boot_on = 1,
> +	}
> +};
> +
> +static struct regulator_init_data vvideo_init = {
> +	.constraints = {
> +		.name = "VVIDEO",
> +		.min_uV = 2500000,
> +		.max_uV = 2775000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.boot_on = 1
> +	}
> +};
> +
> +static struct regulator_init_data vaudio_init = {
> +	.constraints = {
> +		.name = "VAUDIO",
> +		.min_uV = 2300000,
> +		.max_uV = 3000000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +		.boot_on = 1
> +	}
> +};
> +
> +static struct regulator_init_data vsd_init = {
> +	.constraints = {
> +		.name = "VSD",
> +		.min_uV = 1800000,
> +		.max_uV = 3150000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +	}
> +};

I think this is on at power up too (for imx35)

Cheers,
Marc
