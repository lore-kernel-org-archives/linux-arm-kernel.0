From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 10 Aug 2016 11:50:06 -0700
Subject: [PATCH] arm64: qcom: dts: Fix broken interrupt trigger settings
In-Reply-To: <1470826286-19913-1-git-send-email-marc.zyngier@arm.com>
References: <1470826286-19913-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <71392945-e47c-2ec3-6abb-ae2b0a3411af@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 03:51 AM, Marc Zyngier wrote:
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 8 ++++----
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index 11bdc24..45427834 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -483,7 +483,7 @@
>  			compatible = "qcom,ci-hdrc";
>  			reg = <0x78d9000 0x400>;
>  			dr_mode = "peripheral";
> -			interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>;
>  			usb-phy = <&usb_otg>;
>  			status = "disabled";
>  		};
> @@ -491,7 +491,7 @@
>  		usb_host: ehci at 78d9000 {
>  			compatible = "qcom,ehci-host";
>  			reg = <0x78d9000 0x400>;
> -			interrupts = <GIC_SPI 134 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>;
>  			usb-phy = <&usb_otg>;
>  			status = "disabled";
>  		};
> @@ -499,7 +499,7 @@
>  		usb_otg: phy at 78d9000 {
>  			compatible = "qcom,usb-otg-snps";
>  			reg = <0x78d9000 0x400>;
> -			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_BOTH>,
> +			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
>  				     <GIC_SPI 140 IRQ_TYPE_EDGE_RISING>;

These are all level high.

>  
>  			qcom,vdd-levels = <500000 1000000 1320000>;
> @@ -594,7 +594,7 @@
>  			      <0x200a000 0x002100>;
>  			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>  			interrupt-names = "periph_irq";
> -			interrupts = <GIC_SPI 190 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;

This is right.

>  			qcom,ee = <0>;
>  			qcom,channel = <0>;
>  			#address-cells = <2>;
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 55ec3e8..69ed6e1 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -339,7 +339,7 @@
>  			      <0x400a000 0x002100>;
>  			reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
>  			interrupt-names = "periph_irq";
> -			interrupts = <GIC_SPI 326 IRQ_TYPE_NONE>;
> +			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>;
>  			qcom,ee = <0>;
>  			qcom,channel = <0>;
>  			#address-cells = <2>;

This is right too.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
