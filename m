From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 30 Nov 2017 17:07:55 +0000
Subject: [PATCH v3 3/6] ARM: ep93xx: ts72xx: Rewrite
 ts72xx_register_flash() to accept parameters
In-Reply-To: <20171130004510.23887-4-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130004510.23887-1-lukma@denx.de> <20171130004510.23887-4-lukma@denx.de>
Message-ID: <BLUPR0101MB15543BEDECA1A09D483AA5CDD0380@BLUPR0101MB1554.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 29, 2017 5:45 PM, Lukasz Majewski wrote:
> This commit extend the ts72xx_register_flash() to accept passed parameters, which makes it more reusable.
>
> Now it is possible to accept ep93xx flash start address and partitions.

<snip>

@@ -223,7 +217,9 @@ static struct platform_device ts73xx_fpga_device = {  static void __init ts72xx_init_machine(void)  {

Lukasz,

The line above is corrupted in the patch and will not apply. Not sure what happened...

>  	ep93xx_init_devices();
> -	ts72xx_register_flash();
> +	ts72xx_register_flash(ts72xx_nand_parts, ARRAY_SIZE(ts72xx_nand_parts),
> +			      is_ts9420_installed() ?
> +			      EP93XX_CS7_PHYS_BASE : EP93XX_CS6_PHYS_BASE);
>  	platform_device_register(&ts72xx_rtc_device);
>  	platform_device_register(&ts72xx_wdt_device);

Regards,
Hartley
