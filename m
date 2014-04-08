From: svarbanov@mm-sol.com (Stanimir Vabanov)
Date: Wed, 09 Apr 2014 00:36:28 +0300
Subject: [PATCH v2] ARM: qcom: Add initial IPQ8064 SoC and AP148 device
 trees
In-Reply-To: <1396972276-11549-1-git-send-email-galak@codeaurora.org>
References: <1396972276-11549-1-git-send-email-galak@codeaurora.org>
Message-ID: <53446BDC.2050609@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kumar,

<snip>

> diff --git a/arch/arm/boot/dts/qcom-ipq8064-ap148.dts b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> new file mode 100644
> index 0000000..5e6f456
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064-ap148.dts
> @@ -0,0 +1,12 @@
> +#include "qcom-ipq8064-v1.0.dtsi"
> +
> +/ {
> +	model = "Qualcomm IPQ8064/DB149";
> +	compatible = "qcom,ipq8064-db149", "qcom,ipq8064";

The patch subject saying AP148, and here AP149. Which is the wrong one?

> +
> +	soc {
> +		serial at 16340000 {
> +			status = "ok";
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> new file mode 100644
> index 0000000..7093b07
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064-v1.0.dtsi
> @@ -0,0 +1 @@
> +#include "qcom-ipq8064.dtsi"
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> new file mode 100644
> index 0000000..8ca3b51
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi

<snip>

> +
> +		intc: interrupt-controller at 2000000 {
> +			compatible = "qcom,msm-qgic2";
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			reg = < 0x02000000 0x1000 >,
> +			      < 0x02002000 0x1000 >;

extra spaces around these numbers

regards,
Stan
