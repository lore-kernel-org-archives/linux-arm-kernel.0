From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 6 Mar 2017 06:35:42 -0800
Subject: [PATCH 1/2] ARM: dts: add SDC2 and SDC4 to the MSM8660 family
In-Reply-To: <20170306080029.3422-1-linus.walleij@linaro.org>
References: <20170306080029.3422-1-linus.walleij@linaro.org>
Message-ID: <20170306143542.GY25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06, Linus Walleij wrote:
> To make the picture complete, add DTS entries also for the
> second and fourth MMC/SD blocks on the MSM8660. SDC2 is
> an 8-bit interface and SDC4 is a 4-bit interface.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-msm8660.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
> index 91c9a62ae725..5564ad131325 100644
> --- a/arch/arm/boot/dts/qcom-msm8660.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
> @@ -392,6 +392,22 @@
>  				cap-mmc-highspeed;
>  			};
>  
> +			sdcc2: sdcc at 12140000 {
> +				status		= "disabled";
> +				compatible	= "arm,pl18x", "arm,primecell";
> +				arm,primecell-periphid = <0x00051180>;
> +				reg		= <0x12140000 0x8000>;
> +				interrupts	= <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-names	= "cmd_irq";
> +				clocks		= <&gcc SDC2_CLK>, <&gcc SDC2_H_CLK>;
> +				clock-names	= "mclk", "apb_pclk";
> +				bus-width	= <8>;
> +				max-frequency	= <48000000>;
> +				non-removable;

Should things like non-removable or max-frequency be specified in
the base dts? Those seem like board attributes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
