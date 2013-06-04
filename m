From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 04 Jun 2013 17:16:36 +0200
Subject: [PATCH v2 5/6] ARM: hi3xxx: add board support with device tree
In-Reply-To: <1370358317-12768-6-git-send-email-haojian.zhuang@linaro.org>
References: <1370358317-12768-1-git-send-email-haojian.zhuang@linaro.org>
 <1370358317-12768-6-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1456134.qV9IZTo572@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 04 June 2013 23:05:16 Haojian Zhuang wrote:

> +static void __init hi3xxx_timer_init(void)
> +{
> +	of_clk_init(NULL);
> +	clocksource_of_init();
> +}

I plan to make this the default, so maybe we will be able to get rid
of this function soon. Right now it is still needed, as we only
call clocksource_of_init() but not of_clk_init().

> +static void __init hs_init(void)
> +{
> +	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +}

However, this is the default already. You can remove.

> +static const char *hs_compat[] __initdata = {
> +	"hisilicon,hi3620-hi4511",
> +	NULL,
> +};
> +
> +DT_MACHINE_START(HI3xxx, "Hisilicon Hi36xx/Hi37xx (Flattened Device Tree)")
> +	/* Maintainer: Haojian Zhuang <haojian.zhuang@linaro.org> */
> +	.map_io		= debug_ll_io_init,
> +	.init_time	= hi3xxx_timer_init,
> +	.init_machine	= hs_init,
> +	.dt_compat	= hs_compat,
> +MACHINE_END

Same for debug_ll_io_init. You can remove the map_io and init_machine lines
here.

With those gone,

Acked-by: Arnd Bergmann <arnd@arndb.de>

	Arnd
