From: alexgershgorin@gmail.com (Alex Gershgorin)
Date: Fri, 23 Mar 2012 20:11:07 +0200
Subject: [PATCH] regulator: i.MX35-PDK Add regulator support
Message-ID: <1332526267-3236-1-git-send-email-alexg@meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alex <alexg@meprolight.com>

Hi Marc,

Thanks for the patches.

v4 3/4 not directly applicable to Linux version 3.3,
I installed it manually, you could check it out?

> > I'm not very experienced with the regulator driver, but noticed a couple of 
> > minor things with your patch...

I think that my experience in the regulator driver a little less than you :-)

>  static struct resource mx35pdk_flash_resource = {
>  	.start	= MX35_CS0_BASE_ADDR,
> -	.end	= MX35_CS0_BASE_ADDR + SZ_64M - 1,
> +	.end    = MX35_CS0_BASE_ADDR + SZ_64M - 1,

> > did you mean to change this?

No, I will correct this.

> +static struct regulator_init_data vsd_init = {
> +	.constraints = {
> +		.name = "VSD",
> +		.min_uV = 1800000,
> +		.max_uV = 3150000,
> +		.valid_ops_mask = REGULATOR_CHANGE_VOLTAGE,
> +	}
> +};

> > I think this is on at power up too (for imx35)

Maybe you're right, but in this case, the i.MX35 PDK
Do not use PMIC "VSD" regulator, but instead it is used 
a different power source.
I think it can be removed from here :-)


Regards,
Alex Gershgorin
