From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 11:39:51 -0800
Subject: [PATCH 2/6] arm64: dts: apq8016-sbc: add support to hdmi audio
 via adv7533
In-Reply-To: <1483536902-21450-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536902-21450-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1483536902-21450-3-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20170109193951.GO17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/04, Srinivas Kandagatla wrote:
> diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> index 08bd5eb..5ab277f 100644
> --- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
> @@ -85,6 +85,7 @@
>  				pinctrl-names = "default","sleep";
>  				pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
>  				pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
> +				#sound-dai-cells = <1>;
>  
>  				ports {
>  					#address-cells = <1>;
> @@ -285,6 +286,15 @@
>                          qcom,audio-routing =
>                                  "AMIC2", "MIC BIAS Internal2",
>                                  "AMIC3", "MIC BIAS External1";
> +			external-dai-link at 0 {
> +				link-name = "ADV7533";
> +				cpu { /* QUAT */
> +					sound-dai = <&lpass MI2S_QUATERNARY>;
> +				};
> +				codec {
> +					sound-dai = <&adv_bridge 0>;
> +				};
> +			};
>  
>                          internal-codec-playback-dai-link at 0 {            /* I2S - Internal codec */
>                                  link-name = "WCD";

The spacing is weird here. Did the internal-codec get added
without tabs before?


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
