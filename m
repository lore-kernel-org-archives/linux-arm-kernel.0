From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 26 Jun 2013 10:51:09 +0200
Subject: [PATCH 2/5] ARM: at91: dt: rm9200: add spi support
In-Reply-To: <1371472710-18535-2-git-send-email-plagnioj@jcrosoft.com>
References: <20130617123645.GA21034@game.jcrosoft.org>
 <1371472710-18535-1-git-send-email-plagnioj@jcrosoft.com>
 <1371472710-18535-2-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51CAAB7D.6080104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/2013 14:38, Jean-Christophe PLAGNIOL-VILLARD :
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

stacked on at91-3.11-dt

> ---
>   arch/arm/boot/dts/at91rm9200.dtsi |   20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
> index b91cf78..1fc645e 100644
> --- a/arch/arm/boot/dts/at91rm9200.dtsi
> +++ b/arch/arm/boot/dts/at91rm9200.dtsi
> @@ -474,6 +474,15 @@
>   					};
>   				};
>
> +				spi0 {
> +					pinctrl_spi0: spi0-0 {
> +						atmel,pins =
> +							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA0 periph A SPI0_MISO pin */
> +							 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA1 periph A SPI0_MOSI pin */
> +							 AT91_PIOA 2 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA2 periph A SPI0_SPCK pin */
> +					};
> +				};
> +
>   				pioA: gpio at fffff400 {
>   					compatible = "atmel,at91rm9200-gpio";
>   					reg = <0xfffff400 0x200>;
> @@ -574,6 +583,17 @@
>   				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 2>;
>   				status = "disabled";
>   			};
> +
> +			spi0: spi at fffe0000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "atmel,at91rm9200-spi";
> +				reg = <0xfffe0000 0x200>;
> +				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 3>;
> +				pinctrl-names = "default";
> +				pinctrl-0 = <&pinctrl_spi0>;
> +				status = "disabled";
> +			};
>   		};
>
>   		nand0: nand at 40000000 {
>


-- 
Nicolas Ferre
