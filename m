From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 6 Feb 2017 21:35:38 -0800
Subject: [PATCH 1/2] arm: dts: qcom: msm8974: Add RPMCC DT node
In-Reply-To: <20170203183614.28135-1-georgi.djakov@linaro.org>
References: <20170203183614.28135-1-georgi.djakov@linaro.org>
Message-ID: <20170207053538.GE27837@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 03 Feb 10:36 PST 2017, Georgi Djakov wrote:

> Add the RPM Clock Controller DT node for msm8974-based platforms, so that
> drivers can use the clocks provided by the RPM processor.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
> index d3e1a61b8671..4b4c61e2ee35 100644
> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
> @@ -2,6 +2,7 @@
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/clock/qcom,gcc-msm8974.h>
> +#include <dt-bindings/clock/qcom,rpmcc.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/reset/qcom,gcc-msm8974.h>
>  #include "skeleton.dtsi"
> @@ -760,6 +761,11 @@
>  				compatible = "qcom,rpm-msm8974";
>  				qcom,smd-channels = "rpm_requests";
>  
> +				rpmcc: clock-controller {
> +					compatible = "qcom,rpmcc-msm8974", "qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};
> +
>  				pm8841-regulators {
>  					compatible = "qcom,rpm-pm8841-regulators";
>  
