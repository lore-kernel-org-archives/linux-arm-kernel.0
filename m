From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 9 Feb 2015 10:24:35 +0100
Subject: [PATCH v2] ARM: at91: dts: sama5d4: add dts for sama5d4
 xplained board
In-Reply-To: <1423473423-17798-1-git-send-email-josh.wu@atmel.com>
References: <1423473423-17798-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20150209102435.56f39b81@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Josh,

On Mon, 9 Feb 2015 17:17:03 +0800
Josh Wu <josh.wu@atmel.com> wrote:

> Add at91 sama5d4 xplained board support.
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
> 
> Changes in v2:
> - to be sorted by memory address, put the adc dt node after usart4.
> 
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 232 ++++++++++++++++++++++++++++
>  2 files changed, 233 insertions(+)
>  create mode 100644 arch/arm/boot/dts/at91-sama5d4_xplained.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 91bd5bd..bbfbad6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -49,6 +49,7 @@ dtb-$(CONFIG_ARCH_AT91)	+= sama5d34ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d35ek.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= sama5d36ek.dtb
>  # sama5d4
> +dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4_xplained.dtb
>  dtb-$(CONFIG_ARCH_AT91)	+= at91-sama5d4ek.dtb
>  
>  dtb-$(CONFIG_ARCH_ATLAS6) += atlas6-evb.dtb
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> new file mode 100644
> index 0000000..a04c3c8
> --- /dev/null
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -0,0 +1,232 @@
> +/*
> + * at91-sama5d4_xplained.dts - Device Tree file for SAMA5D4 Xplained board
> + *
> + *  Copyright (C) 2015 Atmel,
> + *                2015 Josh Wu <josh.wu@atmel.com>
> + *

[...]

> +	ahb {
> +		apb {
> +			spi0: spi at f8010000 {
> +				cs-gpios = <&pioC 3 0>, <0>, <0>, <0>;
> +				status = "okay";
> +				m25p80 at 0 {
> +					compatible = "atmel,at25df321a";
> +					spi-max-frequency = <50000000>;
> +					reg = <0>;
> +				};
> +			};
> +
> +			macb0: ethernet at f8020000 {
> +				phy-mode = "rmii";
> +				status = "okay";

Could you define the PHY device attached to this ethernet MAC IP ?


                                ethernet-phy at 1 {
                                        reg = <0x1>;
                                        /*
					 * interrupt-parent = <&pioB>;
					 * interrupts = <25
					 *	   IRQ_TYPE_EDGE_FALLING>;
					 */
					/* ... */
				};


Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
