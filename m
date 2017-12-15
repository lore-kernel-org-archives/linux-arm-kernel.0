From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 15 Dec 2017 15:48:55 +0100
Subject: [PATCH v2] ARM64: dts: meson-axg: add the SPICC controller
In-Reply-To: <20171215144217.223593-1-yixun.lan@amlogic.com>
References: <20171215144217.223593-1-yixun.lan@amlogic.com>
Message-ID: <19ed304f-ac35-e7a5-6722-b2cfde8f7bdd@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/2017 15:42, Yixun Lan wrote:
> From: Sunny Luo <sunny.luo@amlogic.com>
> 
> Add DT info for the SPICC controller which found in
> the Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> ---
> Changes int v2 since [1]
>  - rebase to Kevin's tree, branch v4.16/dt64
>  - this patch depend on clock & pinctrl DT patch
> 
> [1]
> http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005495.html
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 93 ++++++++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index d356ce74ad89..d33721005748 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/axg-clkc.h>
>  
>  / {
>  	compatible = "amlogic,meson-axg";
> @@ -120,6 +121,28 @@
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
>  
> +			spicc0: spi at 13000 {
> +				compatible = "amlogic,meson-axg-spicc";
> +				reg = <0x0 0x13000 0x0 0x3c>;
> +				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc CLKID_SPICC0>;
> +				clock-names = "core";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				status = "disabled";
> +			};
> +

[...]

> +
> +				spi1_ss0_x_pins: spi1_ss0_x {
> +					mux {
> +						groups = "spi1_ss0_x";
> +						function = "spi1";
> +					};
> +				};
>  			};
>  		};
>  
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
