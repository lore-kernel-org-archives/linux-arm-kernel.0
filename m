From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Aug 2015 17:22:57 -0700
Subject: [PATCH 1/2] ARM: qcom: add mdio bus on IPQ806x/AP148
In-Reply-To: <1440006802-2415-1-git-send-email-mathieu@codeaurora.org>
References: <1440006802-2415-1-git-send-email-mathieu@codeaurora.org>
Message-ID: <20150825002257.GA19120@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/19, Mathieu Olivari wrote:
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> index 6886d09..d73df24 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> +++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> @@ -19,8 +19,9 @@
>  		};
>  	};
>  
> -	alias {
> +	aliases {

Good catch!

>  		serial0 = &uart4;
> +		mdio-gpio0 = &mdio0;
>  	};
>  
>  	chosen {
> @@ -93,5 +103,24 @@
>  		sata at 29000000 {
>  			status = "ok";
>  		};
> +
> +		mdio0: mdio {

This node should be at the root level, not inside the soc node.

> +			compatible = "virtual,mdio-gpio";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			gpios = <&qcom_pinmux 1 0 &qcom_pinmux 0 0>;
> +			pinctrl-0 = <&mdio0_pins>;
> +			pinctrl-names = "default";
> +
> +			phy0: ethernet-phy at 0 {
> +				device_type = "ethernet-phy";
> +				reg = <0>;
> +			};
> +
> +			phy4: ethernet-phy at 4 {
> +				device_type = "ethernet-phy";
> +				reg = <4>;
> +			};
> +		};
>  	};
>  };

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
