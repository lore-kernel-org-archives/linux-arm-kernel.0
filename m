From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 16 Sep 2014 16:08:11 -0700
Subject: [PATCH] ARM: dts: Add initial DTS file for Sony Xperia Z1 phone
In-Reply-To: <5418C1D2.4000303@sonymobile.com>
References: <5418C1D2.4000303@sonymobile.com>
Message-ID: <27E278AA-EBC0-4368-B75C-DCB2DD906612@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 16, 2014, at 4:03 PM, Tim Bird <tim.bird@sonymobile.com> wrote:

> This DTS has initial support for just a serial console, for the
> Sony Xperia Z1 phone.  This phone uses a QualComm 8074 processor.
> 

Qualcomm, the C isn?t caps.

> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ---
> arch/arm/boot/dts/Makefile                   |    1 +
> arch/arm/boot/dts/qcom-apq8074-xperia-z1.dts |   18 ++++++++++++++++++
> 2 files changed, 19 insertions(+)
> create mode 100644 arch/arm/boot/dts/qcom-apq8074-xperia-z1.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..680ce7e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -341,6 +341,7 @@ dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
> dtb-$(CONFIG_ARCH_QCOM) += \
> 	qcom-apq8064-ifc6410.dtb \
> 	qcom-apq8074-dragonboard.dtb \
> +	qcom-apq8074-xperia-z1.dtb \
> 	qcom-apq8084-mtp.dtb \
> 	qcom-msm8660-surf.dtb \
> 	qcom-msm8960-cdp.dtb
> diff --git a/arch/arm/boot/dts/qcom-apq8074-xperia-z1.dts b/arch/arm/boot/dts/qcom-apq8074-xperia-z1.dts
> new file mode 100644
> index 0000000..59b3fa1
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-apq8074-xperia-z1.dts
> @@ -0,0 +1,18 @@
> +#include "qcom-msm8974.dtsi"
> +
> +/ {
> +	model = "Sony Xperia Z1 phone";
> +	compatible = "qcom,msm8974?;

Should have a board compat as well

> +	qcom,msm-id = <126 8 0>, <185 8 0>, <186 8 0>;

We don?t have qcom,msm-id upstream at this time.

> +
> +	memory at 0 {
> +		reg = <0 0x40000000>, <0x40000000 0x40000000>;
> +		device_type = "memory";
> +	};
> +};
> +
> +&soc {
> +	serial at f991e000 {
> +		status = "ok";
> +	};
> +};
> -- 
> 1.7.9.5
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
