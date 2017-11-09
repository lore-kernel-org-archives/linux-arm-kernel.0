From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Thu, 9 Nov 2017 08:56:05 -0800
Subject: [PATCH 3/4] arm64: dts: qcom: msm8916: normalize I2C bindings
In-Reply-To: <20171101175335.22123-4-damien.riegel@savoirfairelinux.com>
References: <20171101175335.22123-1-damien.riegel@savoirfairelinux.com>
 <20171101175335.22123-4-damien.riegel@savoirfairelinux.com>
Message-ID: <20171109165605.GB28761@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 01 Nov 10:53 PDT 2017, Damien Riegel wrote:

> The QUP core can be used either for I2C or SPI, so the same IP is mapped
> by a driver or the other. SPI bindings use a leading 0 for the start
> address and a size of 0x600, I2C bindings don't have the leading 0 and
> have a size 0x1000.
> 
> To make them more similar, add the leading 0 to I2C bindings and changes
> the size to 0x600, as the driver only accesses registers up to address
> 0x408. Also align the second entry of the clocks array.
> 

The correct size for these blocks are 0x500, please update this. Other
than that this looks good.

Regards,
Bjorn

> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index e16ba8334518..de25bd6070f5 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -457,10 +457,10 @@
>  
>  		blsp_i2c2: i2c at 78b6000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78b6000 0x1000>;
> +			reg = <0x078b6000 0x600>;
>  			interrupts = <GIC_SPI 96 0>;
>  			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> -				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
> +				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
>  			clock-names = "iface", "core";
>  			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&i2c2_default>;
> @@ -472,10 +472,10 @@
>  
>  		blsp_i2c4: i2c at 78b8000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78b8000 0x1000>;
> +			reg = <0x078b8000 0x600>;
>  			interrupts = <GIC_SPI 98 0>;
>  			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> -				<&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
> +				 <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
>  			clock-names = "iface", "core";
>  			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&i2c4_default>;
> @@ -487,10 +487,10 @@
>  
>  		blsp_i2c6: i2c at 78ba000 {
>  			compatible = "qcom,i2c-qup-v2.2.1";
> -			reg = <0x78ba000 0x1000>;
> +			reg = <0x078ba000 0x600>;
>  			interrupts = <GIC_SPI 100 0>;
>  			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
> -				<&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
> +				 <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
>  			clock-names = "iface", "core";
>  			pinctrl-names = "default", "sleep";
>  			pinctrl-0 = <&i2c6_default>;
> -- 
> 2.15.0
> 
