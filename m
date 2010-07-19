From: c.aeschlimann@acn-group.ch (Christophe Aeschlimann)
Date: Mon, 19 Jul 2010 16:22:43 +0200
Subject: [PATCH v2] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <4C44515A.4030003@criticallink.com>
References: <4C44515A.4030003@criticallink.com>
Message-ID: <4C445FB3.5050901@acn-group.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Nice to see a new board based on the OMAP-L138.

A small comment below.

On 19.07.2010 15:21, Michael Williamson wrote:

[...]

> +static struct davinci_i2c_platform_data mityomap_i2c_0_pdata = {
> +    .bus_freq    = 100,    /* kHz */
> +    .bus_delay    = 0,    /* usec */
> +};
> +
> +/* TPS65070 voltage regulator support */

The comment doesn't match what _you are_ supporting.

> +
> +/* 1.2V Core */
> +struct regulator_consumer_supply tps65023_dcdc1_consumers[] = {
> +    {
> +        .supply = "cvdd",
> +    },
> +};
> +
> +/* 1.8V */
> +struct regulator_consumer_supply tps65023_dcdc2_consumers[] = {
> +    {
> +        .supply = "usb0_vdda18",
> +    },
> +    {
> +        .supply = "usb1_vdda18",
> +    },
> +    {
> +        .supply = "ddr_dvdd18",
> +    },
> +    {
> +        .supply = "sata_vddr",
> +    },
> +};
> +

[...]

Regards,

-- 
Christophe Aeschlimann

Embedded Software Engineer

Advanced Communications Networks S.A.

Rue du Puits-Godet 8a
2000 Neuch?tel, Switzerland

T?l. +41 32 724 74 31

c.aeschlimann at acn-group.ch
