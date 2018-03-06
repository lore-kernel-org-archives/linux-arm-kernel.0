From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 6 Mar 2018 08:43:51 -0600
Subject: [PATCH 1/3] arm64: dts: msm8916: Add cpu cooling maps
In-Reply-To: <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
References: <cover.1520340931.git.amit.kucheria@linaro.org>
 <9f7199f0027ef2382e5ccc61a5118d0a00fa2e63.1520340931.git.amit.kucheria@linaro.org>
Message-ID: <CAL_Jsq+QRTi6MnsnZeDVzUXsj5ya0OBROp8HeZ1cX+F=EGtoCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Viresh

On Tue, Mar 6, 2018 at 7:05 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> From: Rajendra Nayak <rnayak@codeaurora.org>
>
> Add cpu cooling maps for cpu passive trip points. The cpu cooling
> device states are mapped to cpufreq based scaling frequencies.
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> index e468277..acac9e3 100644
> --- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/clock/qcom,gcc-msm8916.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8916.h>
>  #include <dt-bindings/clock/qcom,rpmcc.h>
> +#include <dt-bindings/thermal/thermal.h>
>
>  / {
>         model = "Qualcomm Technologies, Inc. MSM8916";
> @@ -115,6 +116,10 @@
>                         cpu-idle-states = <&CPU_SPC>;
>                         clocks = <&apcs 0>;
>                         operating-points-v2 = <&cpu_opp_table>;
> +                       /* cooling options */
> +                       cooling-min-level = <0>;
> +                       cooling-max-level = <7>;

Viresh is working on removing these from the binding...

> +                       #cooling-cells = <2>;
>                 };
>
>                 CPU1: cpu at 1 {
