From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Jun 2018 09:58:06 -0700
Subject: [PATCH] arm64: dts: qcom: Add pm8005 and pm8998 support
In-Reply-To: <20180613152054.54812-1-swboyd@chromium.org>
References: <20180613152054.54812-1-swboyd@chromium.org>
Message-ID: <20180622165806.GC10336@builder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 13 Jun 08:20 PDT 2018, Stephen Boyd wrote:

> Add basic support for the pm8005 and pm8998 PMICs. For now just support
> the GPIO controllers.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/pm8005.dtsi | 33 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 55 ++++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8005.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8998.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8005.dtsi b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> new file mode 100644
> index 000000000000..4d5aca3eeb69
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8005.dtsi
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/* Copyright 2018 Google LLC. */
> +
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&spmi_bus {
> +	pm8005_lsid0: pmic at 4 {
> +		compatible = "qcom,pm8005", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8005_gpio: gpios at c000 {
> +			compatible = "qcom,pm8005-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +				     <0 0xc1 0 IRQ_TYPE_NONE>,
> +				     <0 0xc2 0 IRQ_TYPE_NONE>,
> +				     <0 0xc3 0 IRQ_TYPE_NONE>;
> +		};
> +
> +	};
> +
> +	pm8005_lsid1: pmic at 5 {
> +		compatible = "qcom,pm8005", "qcom,spmi-pmic";
> +		reg = <0x5 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> new file mode 100644
> index 000000000000..92bed1e7d4bb
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -0,0 +1,55 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/* Copyright 2018 Google LLC. */
> +
> +#include <dt-bindings/spmi/spmi.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +&spmi_bus {
> +	pm8998_lsid0: pmic at 0 {
> +		compatible = "qcom,pm8998", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8998_gpio: gpios at c000 {
> +			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
> +				     <0 0xc1 0 IRQ_TYPE_NONE>,
> +				     <0 0xc2 0 IRQ_TYPE_NONE>,
> +				     <0 0xc3 0 IRQ_TYPE_NONE>,
> +				     <0 0xc4 0 IRQ_TYPE_NONE>,
> +				     <0 0xc5 0 IRQ_TYPE_NONE>,
> +				     <0 0xc6 0 IRQ_TYPE_NONE>,
> +				     <0 0xc7 0 IRQ_TYPE_NONE>,
> +				     <0 0xc8 0 IRQ_TYPE_NONE>,
> +				     <0 0xc9 0 IRQ_TYPE_NONE>,
> +				     <0 0xca 0 IRQ_TYPE_NONE>,
> +				     <0 0xcb 0 IRQ_TYPE_NONE>,
> +				     <0 0xcc 0 IRQ_TYPE_NONE>,
> +				     <0 0xcd 0 IRQ_TYPE_NONE>,
> +				     <0 0xce 0 IRQ_TYPE_NONE>,
> +				     <0 0xcf 0 IRQ_TYPE_NONE>,
> +				     <0 0xd0 0 IRQ_TYPE_NONE>,
> +				     <0 0xd1 0 IRQ_TYPE_NONE>,
> +				     <0 0xd2 0 IRQ_TYPE_NONE>,
> +				     <0 0xd3 0 IRQ_TYPE_NONE>,
> +				     <0 0xd4 0 IRQ_TYPE_NONE>,
> +				     <0 0xd5 0 IRQ_TYPE_NONE>,
> +				     <0 0xd6 0 IRQ_TYPE_NONE>,
> +				     <0 0xd7 0 IRQ_TYPE_NONE>,
> +				     <0 0xd8 0 IRQ_TYPE_NONE>,
> +				     <0 0xd9 0 IRQ_TYPE_NONE>;
> +		};
> +
> +	};
> +
> +	pm8998_lsid1: pmic at 1 {
> +		compatible = "qcom,pm8998", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +};
> -- 
> Sent by a computer through tubes
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
