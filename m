From: galak@codeaurora.org (Kumar Gala)
Date: Wed, 24 Sep 2014 13:21:12 -0500
Subject: [PATCH v2] ARM: dts: Add initial DTS file for Sony Xperia Z1
In-Reply-To: <5422DF46.90306@sonymobile.com>
References: <5422DF46.90306@sonymobile.com>
Message-ID: <B9941F2B-B82A-475B-A482-9C774E3C11FA@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Sep 24, 2014, at 10:12 AM, Tim Bird <tim.bird@sonymobile.com> wrote:

> This DTS has support for the Sony Xperia Z1 phone (codenamed Honami).
> This first version of the DTS supports just a serial console.
> 
> changes from v1
> - removed qcom,msm-id attribute
> - removed mis-capitalized Qualcomm word
> - changed dts file name
> - added board-specific compatible-string
> 
> Signed-off-by: Tim Bird <tim.bird@sonymobile.com>
> ?

Does this actually boot?  I?d be surprised since ?qcom,msm8974? isn?t in the match table (just sent a patch for that).

> Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +
> arch/arm/boot/dts/Makefile                            |  3 ++-
> arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts | 17 +++++++++++++++++
> 3 files changed, 20 insertions(+), 1 deletion(-)
> create mode 100644 arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index ac7269f..d3a4579 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -128,6 +128,7 @@ sirf	SiRF Technology, Inc.
> smsc	Standard Microsystems Corporation
> snps 	Synopsys, Inc.
> solidrun	SolidRun
> +sony	Sony Corporation
> spansion	Spansion Inc.
> st	STMicroelectronics
> ste	ST-Ericsson
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b8c5cd3..0c2702e 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -343,7 +343,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
> 	qcom-apq8074-dragonboard.dtb \
> 	qcom-apq8084-mtp.dtb \
> 	qcom-msm8660-surf.dtb \
> -	qcom-msm8960-cdp.dtb
> +	qcom-msm8960-cdp.dtb \
> +	qcom-msm8974-sony-honami-xperia.dtb
> dtb-$(CONFIG_ARCH_ROCKCHIP) += \
> 	rk3066a-bqcurie2.dtb \
> 	rk3188-radxarock.dtb \
> diff --git a/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> new file mode 100644
> index 0000000..cccc21b
> --- /dev/null
> +++ b/arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts
> @@ -0,0 +1,17 @@
> +#include "qcom-msm8974.dtsi"
> +
> +/ {
> +	model = "Sony Xperia Z1";
> +	compatible = "sony,xperia-honami", "qcom,msm8974";
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
> 1.8.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
