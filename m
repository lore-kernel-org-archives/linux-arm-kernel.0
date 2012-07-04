From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 4 Jul 2012 11:45:28 +0000
Subject: [PATCH 2/2] ARM: PRIMA2: add PINMUX map for primaII UART1 and
 SPI0/1
In-Reply-To: <1341373400-15763-2-git-send-email-Barry.Song@csr.com>
References: <1341373400-15763-1-git-send-email-Barry.Song@csr.com>
 <1341373400-15763-2-git-send-email-Barry.Song@csr.com>
Message-ID: <201207041145.28418.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 July 2012, Barry Song wrote:
> +/* Padmux settings */
> +static struct pinctrl_map prima2_padmux_map[] = {
> +       PIN_MAP_MUX_GROUP_DEFAULT("uart1", "pinctrl0", NULL, "uart1"),
> +       PIN_MAP_MUX_GROUP_DEFAULT("spi0", "pinctrl0", NULL, "spi0"),
> +       PIN_MAP_MUX_GROUP_DEFAULT("spi1", "pinctrl0", NULL, "spi1"),
> +};
> +
>  static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
>         { .compatible = "simple-bus", },
>         {},
> @@ -41,6 +48,7 @@ static struct of_device_id sirfsoc_of_bus_ids[] __initdata = {
>  void __init sirfsoc_mach_init(void)
>  {
>         of_platform_populate(NULL, sirfsoc_of_bus_ids, prima2_auxdata_lookup, NULL);
> +       pinctrl_register_mappings(prima2_padmux_map, ARRAY_SIZE(prima2_padmux_map));
>  }

I haven't been following pinctrl too closely, but isn't this something
that would normally be represented by putting the lookup table into the
device tree?

	Arnd
