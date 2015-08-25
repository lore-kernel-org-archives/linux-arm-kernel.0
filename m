From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 25 Aug 2015 14:36:01 -0700
Subject: [PATCH v2 3/6] ARM: dts: apq8064-ifc6410: add notify led support.
In-Reply-To: <1439903409-20233-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1439903069-19752-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1439903409-20233-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <55DCDFC1.4010803@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/2015 06:10 AM, Srinivas Kandagatla wrote:
> diff --git a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> index b1f9ddb..08daafe 100644
> --- a/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> +++ b/arch/arm/boot/dts/qcom-apq8064-ifc6410.dts
> @@ -221,6 +221,18 @@
>   			status = "okay";
>   		};
>   
> +		leds {
> +			compatible = "gpio-leds";
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&notify_led>;
> +
> +			led at 1 {
> +				label = "apq8064:green:user1";
> +				gpios = <&pm8921_gpio 18 GPIO_ACTIVE_HIGH>;
> +				default-state = "on";
> +			};
> +		};

Wrong place. Should be in root, not soc node.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
