From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 18 Jul 2016 10:19:07 -0700
Subject: [PATCH 1/3] ARM: dts: qcom: Add initial DTS for LG Nexus 5 Phone
In-Reply-To: <20160717105208.9596-2-bshah@kde.org>
References: <20160717105208.9596-1-bshah@kde.org>
 <20160717105208.9596-2-bshah@kde.org>
Message-ID: <20160718171907.GF13516@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 17 Jul 03:52 PDT 2016, Bhushan Shah wrote:

[..]
> diff --git a/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> new file mode 100644
> index 0000000..88d494f
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
> @@ -0,0 +1,25 @@
> +#include "qcom-msm8974.dtsi"
> +#include "qcom-pm8841.dtsi"
> +#include "qcom-pm8941.dtsi"
> +
> +/ {
> +	model = "LGE MSM 8974 HAMMERHEAD";
> +	compatible = "qcom,msm8974";

We should have a "lg,hammerhead" here as well, prior to "qcom,msm8974".
Preferably some sort of "product family" definition, if we know of any
to reduce the risk of conflicts with any other hammerheads from LGE.

> +	qcom,msm-id = <126 150 0x20002 0xB>;

We've decided against defining qcom,msm-id in the dts files, so please
drop this.

Instead use dtbTool from git://codeaurora.org/quic/kernel/skales which
should inject the correct information based on the compatible.

> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&soc {
> +

As you're dropping msm-id, please also drop this empty line.

> +	serial at f991d000 {
> +		status = "ok";
> +	};
> +

Dito.

> +};

Regards,
Bjorn
