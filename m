From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 2 Jul 2018 11:48:06 -0700
Subject: [PATCH v4 2/6] dt: qcom: 8996: thermal: Move to DT initialisation
In-Reply-To: <80e54ddfa672ae05db24a90c5f5463fc7fcbec46.1530533998.git.amit.kucheria@linaro.org>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
 <80e54ddfa672ae05db24a90c5f5463fc7fcbec46.1530533998.git.amit.kucheria@linaro.org>
Message-ID: <20180702184806.GA2050@tuxbook-pro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 02 Jul 05:44 PDT 2018, Amit Kucheria wrote:

> We also split up the regmap address space into two, one for the TM
> registers, the other for the SROT registers. This was required to deal with
> different address offsets for the TM and SROT registers across different
> SoC families.
> 
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 8c7f9ca..6c8a857 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -461,7 +461,17 @@
>  
>  		tsens0: thermal-sensor at 4a8000 {
>  			compatible = "qcom,msm8996-tsens";
> -			reg = <0x4a8000 0x2000>;
> +			reg = <0x4a9000 0x1000>, /* TM */
> +			      <0x4a8000 0x1000>; /* SROT */
> +			#qcom,sensors = <13>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
> +		tsens1: thermal-sensor at 4ac000 {
> +			compatible = "qcom,msm8996-tsens";
> +			reg = <0x4ad000 0x1000>, /* TM */
> +			      <0x4ac000 0x1000>; /* SROT */
> +			#qcom,sensors = <8>;
>  			#thermal-sensor-cells = <1>;
>  		};
>  
> -- 
> 2.7.4
> 
