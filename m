From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 2 Jul 2018 11:50:52 -0700
Subject: [PATCH v4 6/6] arm64: dts: sdm845: Add tsens nodes
In-Reply-To: <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <a52b77ad84867774a0659f51ccb79b17ba7638ab.1530533998.git.amit.kucheria@linaro.org>
Message-ID: <20180702185052.GB2050@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> SDM845 has two tsens blocks, one with 13 sensors and the other with 8
> sensors.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb..edf8505 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -221,6 +221,22 @@
>  			#interrupt-cells = <2>;
>  		};
>  
> +		tsens0: tsens at c222000 {
> +			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> +			reg = <0xc263000 0x1ff>, /* TM */
> +			      <0xc222000 0x1ff>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: tsens at c223000 {
> +			compatible = "qcom,tsens-v2.4.0", "qcom,tsens-v2";
> +			reg = <0xc265000 0x1ff>, /* TM */
> +			      <0xc223000 0x1ff>; /* SROT */
> +			#qcom,sensors = <8>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  		spmi_bus: spmi at c440000 {
>  			compatible = "qcom,spmi-pmic-arb";
>  			reg = <0xc440000 0x1100>,
> -- 
> 2.7.4
> 
