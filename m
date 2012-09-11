From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 12:29:17 +0200
Subject: [PATCH 06/14] arm: at91: dt: at91sam9 add pinctrl support
In-Reply-To: <1344603731-32667-6-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-6-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <504F127D.30506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9260.dtsi |    9 +++++++++
>  arch/arm/boot/dts/at91sam9263.dtsi |   12 ++++++++++++
>  arch/arm/boot/dts/at91sam9g45.dtsi |   11 +++++++++++
>  arch/arm/boot/dts/at91sam9n12.dtsi |   10 ++++++++++
>  arch/arm/boot/dts/at91sam9x5.dtsi  |   10 ++++++++++
>  arch/arm/configs/at91_dt_defconfig |    1 +
>  arch/arm/mach-at91/at91sam9263.c   |    5 +++++
>  arch/arm/mach-at91/at91sam9g45.c   |    6 ++++++
>  arch/arm/mach-at91/at91sam9n12.c   |    3 ---
>  arch/arm/mach-at91/at91sam9x5.c    |    7 -------
>  arch/arm/mach-at91/setup.c         |    3 ++-
>  11 files changed, 66 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 4aa155d..353eb53 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -104,6 +104,15 @@
>  				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
>  				reg = <0xfffff400 0x600>;
>  
> +				atmel,mux-mask = <
> +				      /*    A         B     */
> +				       0xffffffff 0xffc00c3b  /* pioA */
> +				       0xffffffff 0x7fff3ccf  /* pioB */
> +				       0xffffffff 0x007fffff  /* pioC */
> +				      >;
> +
> +				/* shared pinctrl settings */
> +
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index f1c838e..e52d5f8 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -95,6 +95,17 @@
>  				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
>  				reg = <0xfffff200 0xa00>;
>  
> +				atmel,mux-mask = <
> +				      /*    A         B     */
> +				       0xfffffffb 0xffffe07f  /* pioA */
> +				       0x0007ffff 0x39072fff  /* pioB */
> +				       0xffffffff 0x3ffffff8  /* pioC */
> +				       0xfffffbff 0xffffffff  /* pioD */
> +				       0xffe00fff 0xfbfcff00  /* pioE */
> +				      >;
> +
> +				/* shared pinctrl settings */
> +
>  				pioA: gpio at fffff200 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff200 0x200>;
> @@ -138,6 +149,7 @@
>  					#gpio-cells = <2>;
>  					gpio-controller;
>  					interrupt-controller;
> +				};
>  			};
>  
>  			dbgu: serial at ffffee00 {
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index f04bc8d..0e64221 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -114,6 +114,17 @@
>  
>  				reg = <0xfffff200 0xa00>;
>  
> +				atmel,mux-mask = <
> +				      /*    A         B     */
> +				       0xffffffff 0xffc003ff  /* pioA */
> +				       0xffffffff 0x800f8f00  /* pioB */
> +				       0xffffffff 0x00000e00  /* pioC */
> +				       0xffffffff 0xff0c1381  /* pioD */
> +				       0xffffffff 0x81ffff81  /* pioE */
> +				      >;
> +
> +				/* shared pinctrl settings */
> +
>  				pioA: gpio at fffff200 {
>  					compatible = "atmel,at91rm9200-gpio";
>  					reg = <0xfffff200 0x200>;
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 575c891..ae23a03 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -107,6 +107,16 @@
>  				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
>  				reg = <0xfffff400 0x800>;
>  
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe07983 0x00000000  /* pioA */
> +				       0x00040000 0x00047e0f 0x00000000  /* pioB */
> +				       0xfdffffff 0x07c00000 0xb83fffff  /* pioC */
> +				       0x003fffff 0x003f8000 0x00000000  /* pioD */
> +				      >;
> +
> +				/* shared pinctrl settings */
> +
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 8b56730..d1df4ea 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -115,6 +115,16 @@
>  				compatible = "atmel,at91rm9200-pinctrl", "simple-bus";
>  				reg = <0xfffff400 0x800>;
>  
> +				atmel,mux-mask = <
> +				      /*    A         B          C     */
> +				       0xffffffff 0xffe0399f 0xc000001c  /* pioA */
> +				       0xffffffff 0xffc003ff 0xffc003ff  /* pioB */
> +				       0xffffffff 0xffc003ff 0xffc003ff  /* pioC */
> +				       0xffffffff 0xffc003ff 0xffc003ff  /* pioD */
> +				      >;
> +
> +				/* shared pinctrl settings */
> +
>  				pioA: gpio at fffff400 {
>  					compatible = "atmel,at91sam9x5-gpio", "atmel,at91rm9200-gpio";
>  					reg = <0xfffff400 0x200>;
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 67bc571..b175577 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -111,6 +111,7 @@ CONFIG_I2C=y
>  CONFIG_I2C_GPIO=y
>  CONFIG_SPI=y
>  CONFIG_SPI_ATMEL=y
> +CONFIG_PINCTRL_AT91=y
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=y
>  CONFIG_AT91SAM9X_WATCHDOG=y
> diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> index 84b3810..ceef453 100644
> --- a/arch/arm/mach-at91/at91sam9263.c
> +++ b/arch/arm/mach-at91/at91sam9263.c
> @@ -210,6 +210,11 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("hclk", "a00000.ohci", &ohci_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "fffa4000.spi", &spi0_clk),
>  	CLKDEV_CON_DEV_ID("spi_clk", "fffa8000.spi", &spi1_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff200.gpio", &pioA_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioB_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioCDE_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioCDE_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioCDE_clk),
>  };
>  
>  static struct clk_lookup usart_clocks_lookups[] = {
> diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> index ef6cedd..8322aa7 100644
> --- a/arch/arm/mach-at91/at91sam9g45.c
> +++ b/arch/arm/mach-at91/at91sam9g45.c
> @@ -256,6 +256,12 @@ static struct clk_lookup periph_clocks_lookups[] = {
>  	CLKDEV_CON_DEV_ID("ehci_clk", "800000.ehci", &uhphs_clk),
>  	/* fake hclk clock */
>  	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff200.gpio", &pioA_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff400.gpio", &pioB_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff600.gpio", &pioC_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffff800.gpio", &pioDE_clk),
> +	CLKDEV_CON_DEV_ID(NULL, "fffffa00.gpio", &pioDE_clk),
> +
>  	CLKDEV_CON_ID("pioA", &pioA_clk),
>  	CLKDEV_CON_ID("pioB", &pioB_clk),
>  	CLKDEV_CON_ID("pioC", &pioC_clk),
> diff --git a/arch/arm/mach-at91/at91sam9n12.c b/arch/arm/mach-at91/at91sam9n12.c
> index 0849466..f4e0e60 100644
> --- a/arch/arm/mach-at91/at91sam9n12.c
> +++ b/arch/arm/mach-at91/at91sam9n12.c
> @@ -221,9 +221,6 @@ static void __init at91sam9n12_map_io(void)
>  void __init at91sam9n12_initialize(void)
>  {
>  	at91_extern_irq = (1 << AT91SAM9N12_ID_IRQ0);
> -
> -	/* Register GPIO subsystem (using DT) */
> -	at91_gpio_init(NULL, 0);
>  }
>  
>  struct at91_init_soc __initdata at91sam9n12_soc = {
> diff --git a/arch/arm/mach-at91/at91sam9x5.c b/arch/arm/mach-at91/at91sam9x5.c
> index 477cf9d..bbd2f8e 100644
> --- a/arch/arm/mach-at91/at91sam9x5.c
> +++ b/arch/arm/mach-at91/at91sam9x5.c
> @@ -310,12 +310,6 @@ static void __init at91sam9x5_map_io(void)
>  	at91_init_sram(0, AT91SAM9X5_SRAM_BASE, AT91SAM9X5_SRAM_SIZE);
>  }
>  
> -void __init at91sam9x5_initialize(void)
> -{
> -	/* Register GPIO subsystem (using DT) */
> -	at91_gpio_init(NULL, 0);
> -}
> -
>  /* --------------------------------------------------------------------
>   *  Interrupt initialization
>   * -------------------------------------------------------------------- */
> @@ -323,5 +317,4 @@ void __init at91sam9x5_initialize(void)
>  struct at91_init_soc __initdata at91sam9x5_soc = {
>  	.map_io = at91sam9x5_map_io,
>  	.register_clocks = at91sam9x5_register_clocks,
> -	.init = at91sam9x5_initialize,
>  };
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index 50c69b5..fcb66ea 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -449,7 +449,8 @@ void __init at91_dt_initialize(void)
>  	/* Register the processor-specific clocks */
>  	at91_boot_soc.register_clocks();
>  
> -	at91_boot_soc.init();
> +	if (at91_boot_soc.init)
> +		at91_boot_soc.init();
>  }
>  #endif

Ok with this, with correction by Richard,

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


-- 
Nicolas Ferre
