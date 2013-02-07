From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 7 Feb 2013 23:36:59 +0530
Subject: [PATCH V2 1/2] ARM: davinci: da850: add wdt DT node
In-Reply-To: <1360123204-9978-2-git-send-email-anilkumar.v@ti.com>
References: <1360123204-9978-1-git-send-email-anilkumar.v@ti.com>
 <1360123204-9978-2-git-send-email-anilkumar.v@ti.com>
Message-ID: <5113ED43.1060609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/6/2013 9:30 AM, Kumar, Anil wrote:
> Add da850 wdt DT node.
> Add OF_DEV_AUXDATA for wdt driver to use wdt clock.
> 
> Signed-off-by: Kumar, Anil <anilkumar.v@ti.com>

> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -37,11 +37,17 @@ static void __init da8xx_init_irq(void)
>  	of_irq_init(da8xx_irq_match);
>  }
>  
> +struct of_dev_auxdata da850_auxdata_lookup[] __initdata = {
> +	OF_DEV_AUXDATA("ti,davinci-wdt", 0x01c21000, "watchdog", NULL),
> +	{}
> +};
> +
>  #ifdef CONFIG_ARCH_DAVINCI_DA850
>  
>  static void __init da850_init_machine(void)
>  {
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_populate(NULL, of_default_bus_match_table,
> +			da850_auxdata_lookup, NULL);

These hunks clashed with Manish's I2C0 node addition. I resolved it
locally. I pushed the commit to v3.9/dt-2 branch of my gitorious tree.
Please use this as the baseline for further DT patches.

Thanks,
Sekhar
