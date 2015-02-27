From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 28 Feb 2015 00:23:05 +0100
Subject: [PATCH 2/2] arm64: dts: Add Qualcomm MSM8916 SoC and evaluation
 board dts
In-Reply-To: <1425075293-14612-2-git-send-email-galak@codeaurora.org>
References: <1425075293-14612-1-git-send-email-galak@codeaurora.org>
 <1425075293-14612-2-git-send-email-galak@codeaurora.org>
Message-ID: <1515839.cKRaf1Kh72@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Freitag, 27. Februar 2015, 16:14:53 schrieb Kumar Gala:
> Add initial device tree support for Qualcomm MSM8916 SoC and MTP8916
> evaluation board.  At the current time we only boot up a single processor.
> 
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> ---
>  arch/arm64/boot/dts/Makefile              |   1 +
>  arch/arm64/boot/dts/qcom/Makefile         |   5 +
>  arch/arm64/boot/dts/qcom/msm8916-mtp.dts  |  21 ++++
>  arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi |  24 ++++
>  arch/arm64/boot/dts/qcom/msm8916.dtsi     | 188
> ++++++++++++++++++++++++++++++ 5 files changed, 239 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/Makefile
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8916.dtsi
> 
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index e0350ca..8517f15 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -5,5 +5,6 @@ dts-dirs += cavium
>  dts-dirs += exynos
>  dts-dirs += freescale
>  dts-dirs += mediatek
> +dts-dirs += qcom
> 
>  subdir-y	:= $(dts-dirs)
> diff --git a/arch/arm64/boot/dts/qcom/Makefile
> b/arch/arm64/boot/dts/qcom/Makefile new file mode 100644
> index 0000000..c1ab1c3
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -0,0 +1,5 @@
> +dtb-$(CONFIG_ARCH_QCOM_MSM8916)	+= msm8916-mtp.dtb
> +
> +always		:= $(dtb-y)
> +subdir-y	:= $(dts-dirs)
> +clean-files	:= *.dtb
> diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
> b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts new file mode 100644
> index 0000000..acfe037
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dts
> @@ -0,0 +1,21 @@
> +/* Copyright (c) 2014-2015, The Linux Foundation. All rights reserved.
> +*
> +* This program is free software; you can redistribute it and/or modify
> +* it under the terms of the GNU General Public License version 2 and
> +* only version 2 as published by the Free Software Foundation.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*/
> +
> +/dts-v1/;
> +
> +#include "msm8916-mtp.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM 8916 MTP";
> +	compatible = "qcom,msm8916-mtp", "qcom,msm8916", "qcom,mtp";
> +	qcom,board-id = <8 0>, <8 1>;

qcom,board-id seems undocumented - grep through devicetree/bindings didn't 
turn up anything. [or I'm just blind]


> +};

[...]

> diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi
> b/arch/arm64/boot/dts/qcom/msm8916.dtsi new file mode 100644
> index 0000000..72ad0f7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
> @@ -0,0 +1,188 @@
> +/* Copyright (c) 2013-2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include "skeleton.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-msm8916.h>
> +#include <dt-bindings/reset/qcom,gcc-msm8916.h>
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. MSM8916";
> +	compatible = "qcom,msm8916";
> +	qcom,msm-id =	<206 0>,
> +			<248 0>,
> +			<249 0>,
> +			<250 0>;

same for this - nothing found in the devicetree/bindings from 4.0-rc1


Heiko
