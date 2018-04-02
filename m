From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 2 Apr 2018 14:46:17 +0530
Subject: [PATCH v4 08/14] dt: qcom: Add opp and thermal to the msm8996
In-Reply-To: <1522358807-10413-9-git-send-email-ilialin@codeaurora.org>
References: <1522358807-10413-1-git-send-email-ilialin@codeaurora.org>
 <1522358807-10413-9-git-send-email-ilialin@codeaurora.org>
Message-ID: <20180402091617.GA3572@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-03-18, 00:26, Ilia Lin wrote:
> Signed-off-by: Ilia Lin <ilialin@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 275 +++++++++++++++++++++++++++++++++-
>  1 file changed, 267 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> index 410ae78..a0792bd 100644
> --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/qcom,gcc-msm8996.h>
>  #include <dt-bindings/clock/qcom,mmcc-msm8996.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/thermal/thermal.h>
>  
>  / {
>  	model = "Qualcomm Technologies, Inc. MSM8996";
> @@ -97,6 +98,11 @@
>  			compatible = "qcom,kryo";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			clocks = <&kryocc 0>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			cooling-min-level = <0>;
> +			cooling-max-level = <15>;

The min/max properties are removed from DT documentation now. You don't need to
add them anymore.

> +	cluster0_opp: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;

Is Kryo like krait where CPUs do DVFS independently ? If yes, then opp-shared
thing should be dropped.

> +
> +		opp-307200000 {
> +			opp-hz = /bits/ 64 <  307200000 >;

Why have you added spaces after < and before > here ?

-- 
viresh
