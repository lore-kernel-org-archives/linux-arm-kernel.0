From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 15 Feb 2018 12:56:41 +0100
Subject: [PATCH v2] ARM64: dts: meson-axg: enable IR controller
In-Reply-To: <20171204053858.1697-1-yixun.lan@amlogic.com>
References: <20171204053858.1697-1-yixun.lan@amlogic.com>
Message-ID: <faa30eb9-9872-bd78-6f25-d6425651887e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/2017 06:38, Yixun Lan wrote:
> Enable IR remote controller which find in Amlogic's Meson-AXG SoC.
> 
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> 
> ---
> 
> Changes since v1 at [1]:
>  - drop the compatbile 'amlogic,meson-gx-ir'
> 
> [1]
>  http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005527.html
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  6 ++++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 0864d1ff2d9b..ca676cafdbb3 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -34,3 +34,9 @@
>  	pinctrl-0 = <&i2c1_z_pins>;
>  	pinctrl-names = "default";
>  };
> +
> +&ir {
> +	status = "okay";
> +	pinctrl-0 = <&remote_input_ao_pins>;
> +	pinctrl-names = "default";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 9bb85893c1b7..f68f709762dd 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -616,6 +616,13 @@
>  					#gpio-cells = <2>;
>  					gpio-ranges = <&pinctrl_aobus 0 0 15>;
>  				};
> +
> +				remote_input_ao_pins: remote_input_ao {
> +					mux {
> +						groups = "remote_input_ao";
> +						function = "remote_input_ao";
> +					};
> +				};
>  			};
>  
>  			i2c_AO: i2c at 5000 {
> @@ -664,6 +671,13 @@
>  				clock-names = "xtal", "pclk", "baud";
>  				status = "disabled";
>  			};
> +
> +			ir: ir at 8000 {
> +				compatible = "amlogic,meson-gxbb-ir";
> +				reg = <0x0 0x8000 0x0 0x20>;
> +				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
