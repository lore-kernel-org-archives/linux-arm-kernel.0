From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 5 Feb 2016 11:54:19 -0800
Subject: [PATCH 2/6] arm64: dts: qcom: apq8016-sbc: add usb support
In-Reply-To: <1454698880-13973-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1454698819-13885-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1454698880-13973-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <56B4FDEB.2080202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2016 11:01 AM, Srinivas Kandagatla wrote:
> +
> +		usb2513 {
> +			compatible = "smsc,usb3503";
> +			reset-gpios = <&pm8916_gpios 3 GPIO_ACTIVE_LOW>;
> +			initial-mode = <1>;
> +		};
> +
> +		usb_id: usb-id {
> +			interrupt-parent = <&msmgpio>;
> +			compatible = "linux,extcon-usb-gpio";
> +			id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&usb_id_default>;
> +		};

These are not on the SoC bus. Please move them to root.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
