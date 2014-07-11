From: knaack.h@gmx.de (Hartmut Knaack)
Date: Fri, 11 Jul 2014 23:57:44 +0200
Subject: [PATCH 2/2] dt-bindings: document Rockchip saradc
In-Reply-To: <3591595.sBj6Zqo42A@diego>
References: <2959154.xc8BQActsn@diego> <3591595.sBj6Zqo42A@diego>
Message-ID: <53C05DD8.9050500@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner schrieb:
> This add the necessary binding documentation for the saradc found in all recent
> processors from Rockchip.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
Spotted some typos, see inline.
>  .../bindings/iio/adc/rockchip-saradc.txt           | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> new file mode 100644
> index 0000000..603ac9c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
> @@ -0,0 +1,28 @@
> +Rockhip Successive Approximation Register (SAR) A/D Converter bindings
Should be "Rockchip".
> +
> +Required properties:
> +- compatible: Should be "rockchip,saradc"
> +- reg: physical base address of the controller and length of memory mapped
> +       region.
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +              depends on the interrupt controller.
> +- clocks: Must contain an entry for each entry in clock-names.
> +- clock-names: Shall be "saradc" for the converter-clock, and "apb_pclk" for
> +               the peripheral clock.
> +- vref-supply: The regulator supply ADC refrence voltage.
... reference voltage.
> +- #io-channel-cells: Should be 1, see ../iio-bindings.txt
> +
> +Optional properties :
> +- clock-frequency : converter frequency in Hz. If omitted, 1MHz is used.
> +
> +Example:
> +	saradc: saradc at 2006c000 {
> +		compatible = "rockchip,saradc";
> +		reg = <0x2006c000 0x100>;
> +		interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_SARADC>, <&cru PCLK_SARADC>;
> +		clock-names = "saradc", "apb_pclk";
> +		#io-channel-cells = <1>;
> +		vref-supply = <&vcc18>;
> +		clock-frequency = <1000000>;
> +	};
