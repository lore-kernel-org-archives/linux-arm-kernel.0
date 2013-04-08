From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 8 Apr 2013 09:35:39 +0200
Subject: [RFC 2/5] ARM: at91/dts: add general purpose backup register
 (GPBR) support
In-Reply-To: <1365347572-14972-2-git-send-email-jhovold@gmail.com>
References: <20130407150938.GA25605@localhost>
 <1365347572-14972-1-git-send-email-jhovold@gmail.com>
 <1365347572-14972-2-git-send-email-jhovold@gmail.com>
Message-ID: <20130408073539.GP20693@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:12 Sun 07 Apr     , Johan Hovold wrote:
> Add arch device-tree setup code and DT-nodes for the General Purpose
> Backup Registers (GPBR).
> 
> Note that all AT91 SoCs but at91rm9200 have these backup-powered
> registers.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt          |  4 ++++
>  arch/arm/boot/dts/at91sam9260.dtsi                  |  5 +++++
>  arch/arm/boot/dts/at91sam9263.dtsi                  |  5 +++++
>  arch/arm/boot/dts/at91sam9g45.dtsi                  |  5 +++++
>  arch/arm/boot/dts/at91sam9n12.dtsi                  |  5 +++++
>  arch/arm/boot/dts/at91sam9x5.dtsi                   |  5 +++++
>  arch/arm/mach-at91/setup.c                          | 21 +++++++++++++++++++++
>  7 files changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> index 1196290..fe64d0a 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
> @@ -1,6 +1,10 @@
>  Atmel AT91 device tree bindings.
>  ================================
>  
> +General Purpose Backup Registers (GPBR) required properties:
> +- compatible: Should be "atmel,at91sam9260-gpbr"
> +- reg: Should contain register location and length
> +
>  PIT Timer required properties:
>  - compatible: Should be "atmel,at91sam9260-pit"
>  - reg: Should contain registers location and length
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index cb7bcc5..48ef04d 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -87,6 +87,11 @@
>  				interrupts = <1 4 7>;
>  			};
>  
> +			gpbr at fffffd50 {
> +				compatible = "atmel,at91sam9260-gpbr";
> +				reg = <0xfffffd50 0x10>;
> +			};
> +
>  			tcb0: timer at fffa0000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfffa0000 0x100>;
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 271d4de..e9676ba 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -75,6 +75,11 @@
>  				interrupts = <1 4 7>;
>  			};
>  
> +			gpbr at fffffd60 {
> +				compatible = "atmel,at91sam9260-gpbr";
> +				reg = <0xfffffd60 0x50>;
> +			};
> +
>  			tcb0: timer at fff7c000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfff7c000 0x100>;
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 6b1d4ca..d5e37ce 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -92,6 +92,11 @@
>  				reg = <0xfffffd10 0x10>;
>  			};
>  
> +			gpbr at fffffd60 {
> +				compatible = "atmel,at91sam9260-gpbr";
> +				reg = <0xfffffd60 0x10>;
> +			};
> +
>  			tcb0: timer at fff7c000 {
>  				compatible = "atmel,at91rm9200-tcb";
>  				reg = <0xfff7c000 0x100>;
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 4801717..ac122a6 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -85,6 +85,11 @@
>  				reg = <0xfffffe10 0x10>;
>  			};
>  
> +			gpbr at fffffe60 {
> +				compatible = "atmel,at91sam9260-gpbr";
> +				reg = <0xfffffe60 0x10>;
> +			};
> +
>  			mmc0: mmc at f0008000 {
>  				compatible = "atmel,hsmci";
>  				reg = <0xf0008000 0x600>;
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index c461e11..13d069e 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -88,6 +88,11 @@
>  				interrupts = <1 4 7>;
>  			};
>  
> +			gpbr at fffffe60 {
> +				compatible = "atmel,at91sam9260-gpbr";
> +				reg = <0xfffffe60 0x10>;
> +			};
> +
>  			tcb0: timer at f8008000 {
>  				compatible = "atmel,at91sam9x5-tcb";
>  				reg = <0xf8008000 0x100>;
> diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
> index b01f4aa..a525390 100644
> --- a/arch/arm/mach-at91/setup.c
> +++ b/arch/arm/mach-at91/setup.c
> @@ -374,6 +374,26 @@ static void at91_dt_ramc(void)
>  	of_node_put(np);
>  }
>  
> +static struct of_device_id gpbr_ids[] = {
> +	{ .compatible = "atmel,at91sam9260-gpbr", },
> +	{ /* sentinel */ }
> +};
> +
> +static void at91_dt_gpbr(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, gpbr_ids);
> +	if (!np)
> +		panic("AT91: failed to find compatible gpbr node in dtb\n");
> +
> +	at91_gpbr_base = of_iomap(np, 0);
> +	if (!at91_gpbr_base)
> +		panic("AT91: Failed to map gpbr registers\n");
> +
> +	of_node_put(np);
> +}

binding ok this NO
no global pointer unless no choice

we need a framework

Best Regards,
J.
> +
>  static struct of_device_id shdwc_ids[] = {
>  	{ .compatible = "atmel,at91sam9260-shdwc", },
>  	{ .compatible = "atmel,at91sam9rl-shdwc", },
> @@ -468,6 +488,7 @@ void __init at91_dt_initialize(void)
>  	at91_dt_rstc();
>  	at91_dt_ramc();
>  	at91_dt_shdwc();
> +	at91_dt_gpbr();
>  
>  	/* Init clock subsystem */
>  	at91_dt_clock_init();
> -- 
> 1.8.1.5
> 
