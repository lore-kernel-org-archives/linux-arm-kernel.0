From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 9 Jan 2017 14:22:03 +0530
Subject: [PATCH 1/4] ARM: dts: move hdmi pinctrl out of board file.
In-Reply-To: <1483536854-21389-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536854-21389-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <68a22bd8-1c24-2448-81b3-61af7bacb1d2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/04/2017 07:04 PM, Srinivas Kandagatla wrote:
> This patch moves hdmi pinctrl defination from board file to soc level
> pinctrl file. If not this pinctrl setup will be duplicated across all
> the apq8064 based board files.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064-ifc6410.dts | 22 ----------------------
>  arch/arm/boot/dts/qcom-apq8064-pins.dtsi   | 19 +++++++++++++++++++
>  arch/arm/boot/dts/qcom-apq8064.dtsi        |  2 ++
>  3 files changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index 3d37cab..881ce70 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -75,25 +75,6 @@
>  					bias-disable;
>  				};
>  			};
> -
> -			hdmi_pinctrl: hdmi-pinctrl {
> -				mux {
> -					pins = "gpio70", "gpio71", "gpio72";
> -					function = "hdmi";
> -				};
> -
> -				pinconf_ddc {
> -					pins = "gpio70", "gpio71";
> -					bias-pull-up;
> -					drive-strength = <2>;
> -				};
> -
> -				pinconf_hpd {
> -					pins = "gpio72";
> -					bias-pull-down;
> -					drive-strength = <16>;
> -				};
> -			};
>  		};
>
>  		rpm at 108000 {
> @@ -368,9 +349,6 @@
>
>  			hpd-gpios = <&tlmm_pinmux 72 GPIO_ACTIVE_HIGH>;
>
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&hdmi_pinctrl>;
> -
>  			ports {
>  				port at 0 {
>  					endpoint {
> diff --git a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> index 6b801e7..cba4450 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064-pins.dtsi
> @@ -284,4 +284,23 @@
>  			bias-disable = <0>;
>  		};
>  	};
> +
> +	hdmi_pinctrl: hdmi-pinctrl {
> +		mux {
> +			pins = "gpio70", "gpio71", "gpio72";
> +			function = "hdmi";
> +		};
> +
> +		pinconf_ddc {
> +			pins = "gpio70", "gpio71";
> +			bias-pull-up;
> +			drive-strength = <2>;
> +		};
> +
> +		pinconf_hpd {
> +			pins = "gpio72";
> +			bias-pull-down;
> +			drive-strength = <16>;
> +		};
> +	};
>  };
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 407a461..e68a8a1 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -1327,6 +1327,8 @@
>
>  		hdmi: hdmi-tx at 4a00000 {
>  			compatible = "qcom,hdmi-tx-8960";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&hdmi_pinctrl>;
>  			reg = <0x04a00000 0x2f0>;
>  			reg-names = "core_physical";
>  			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
