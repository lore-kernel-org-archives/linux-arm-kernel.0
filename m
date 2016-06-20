From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 16:23:52 -0700
Subject: [PATCH 1/8] arm64: dts: db820c: add basic board support
In-Reply-To: <1466452907-23290-2-git-send-email-srinivas.kandagatla@linaro.org>
References: <1466452907-23290-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1466452907-23290-2-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <57687B08.9060900@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/2016 01:01 PM, Srinivas Kandagatla wrote:
> This patch adds apq8096 db820c basic support with serial port.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |  2 +-
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dts  | 21 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 34 ++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index fa1f661..80ecdfe 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,5 +1,5 @@
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb msm8916-mtp.dtb
> -dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb apq8096-db820c.dtb

We should do a new line for each board as other arm64 vendors have done?

> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> new file mode 100644
> index 0000000..e1a55b1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (c) 2014-2016, The Linux Foundation. All rights reserved.
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
> +/dts-v1/;
> +
> +#include "apq8096-db820c.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. DB820c";
> +	compatible = "qcom,apq8096-db820c";

Should be qcom,apq8096-sbc? At least I have to use that on my board to
match the board ids.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
