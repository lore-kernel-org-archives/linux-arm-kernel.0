From: architt@codeaurora.org (Archit Taneja)
Date: Mon, 9 Jan 2017 14:22:55 +0530
Subject: [PATCH 2/4] ARM: dts: sd-600eval: add hdmi support
In-Reply-To: <1483536854-21389-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536854-21389-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1483536854-21389-2-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <8d1d1c3d-2492-19e1-3c6a-912ba8ae57c2@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/04/2017 07:04 PM, Srinivas Kandagatla wrote:
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> ---
>  .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
> index 39ae2bc..4e908af 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts
> @@ -39,6 +39,17 @@
>
>  	};
>
> +	hdmi-out {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con: endpoint {
> +				remote-endpoint = <&hdmi_out>;
> +			};
> +		};
> +	};
> +
>  	soc {
>  		rpm at 108000 {
>  			regulators {
> @@ -347,5 +358,38 @@
>  				cd-gpios	= <&tlmm_pinmux 26 GPIO_ACTIVE_HIGH>;
>  			};
>  		};
> +
> +		hdmi-tx at 4a00000 {
> +			status = "okay";
> +			core-vdda-supply = <&pm8921_hdmi_switch>;
> +			hdmi-mux-supply = <&vcc3v3>;
> +
> +			hpd-gpio = <&tlmm_pinmux 72 GPIO_ACTIVE_HIGH>;
> +
> +			ports {
> +				port at 1 {
> +					endpoint {
> +						remote-endpoint = <&hdmi_con>;
> +					};
> +				};
> +			};
> +		};
> +
> +		hdmi-phy at 4a00400 {
> +			status = "okay";
> +			core-vdda-supply = <&pm8921_hdmi_switch>;
> +		};
> +
> +		mdp at 5100000 {
> +			status = "okay";
> +
> +			ports {
> +				port at 3 {
> +					endpoint {
> +						remote-endpoint = <&hdmi_in>;
> +					};
> +				};
> +			};
> +		};
>  	};
>  };
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
