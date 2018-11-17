From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Sat, 17 Nov 2018 15:11:28 -0800
Subject: [PATCH v5 02/18] arm64: dts: qcom: qcs404-evb: add dts files for
 EVBs
In-Reply-To: <20181109094417.12109-3-vkoul@kernel.org>
References: <20181109094417.12109-1-vkoul@kernel.org>
 <20181109094417.12109-3-vkoul@kernel.org>
Message-ID: <20181117231128.GB2225@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 09 Nov 01:44 PST 2018, Vinod Koul wrote:

> QCS404 has two EVBs, EVB-1000 and EVB-4000. These boards are mostly
> similar with few differences in the peripherals used.
> 
> So use a common qcs404-evb.dtsi which contains the common parts and use
> qcs404-evb-1000.dts and qcs404-evb-4000.dts for diffs
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/Makefile            |  2 ++
>  arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 11 +++++++++++
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 14 ++++++++++++++
>  4 files changed, 38 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index a658c07652a7..21d548f02d39 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -8,3 +8,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
> new file mode 100644
> index 000000000000..2c14903d808e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +/dts-v1/;
> +
> +#include "qcs404-evb.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
> +	compatible = "qcom,qcs404-evb";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> new file mode 100644
> index 000000000000..11269ad3de0d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +/dts-v1/;
> +
> +#include "qcs404-evb.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
> +	compatible = "qcom,qcs404-evb";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> new file mode 100644
> index 000000000000..91ecbdf0ecda
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (c) 2018, Linaro Limited
> +
> +#include "qcs404.dtsi"
> +
> +/ {
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +};
> -- 
> 2.14.4
> 
