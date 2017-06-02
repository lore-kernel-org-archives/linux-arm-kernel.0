From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Jun 2017 15:02:23 -0700
Subject: [PATCH 1/2] ARM: dts: add GSBI8 defines to the MSM8660 family
In-Reply-To: <20170515075012.3696-1-linus.walleij@linaro.org>
References: <20170515075012.3696-1-linus.walleij@linaro.org>
Message-ID: <20170602220223.GR20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Linus Walleij wrote:
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index 747669a62aa8..a53c0f9970bd 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -107,6 +107,31 @@
>  			reg = <0x900000 0x4000>;
>  		};
>  
> +
> +		gsbi8: gsbi at 19800000 {
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <12>;
> +			reg = <0x19800000 0x100>;
> +			clocks = <&gcc GSBI8_H_CLK>;
> +			clock-names = "iface";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon-tcsr = <&tcsr>;
> +
> +			gsbi8_i2c: i2c at 19880000 {
> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				reg = <0x19880000 0x1000>;
> +				interrupts = <0 161 IRQ_TYPE_NONE>;

				interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>?

> +				clocks = <&gcc GSBI8_QUP_CLK>, <&gcc GSBI8_H_CLK>;

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
