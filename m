From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 11:13:55 -0700
Subject: [PATCH v9 3/7] ARM: dts: enable hi4511 with device tree
In-Reply-To: <1377695454-29109-4-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Wed, 28 Aug 2013 21:10:50 +0800")
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
 <1377695454-29109-4-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <87eh9c1i1o.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> Enable Hisilicon Hi4511 development platform with device tree support.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

This still doesn't look quite right... 

> ---
>  arch/arm/boot/dts/Makefile        |    1 +
>  arch/arm/boot/dts/hi3620-clk.dtsi | 1058 +++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/hi3620.dtsi     |  513 ++++++++++++++++++
>  arch/arm/boot/dts/hi4511.dts      |  648 +++++++++++++++++++++++
>  4 files changed, 2220 insertions(+)
>  create mode 100644 arch/arm/boot/dts/hi3620-clk.dtsi
>  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
>  create mode 100644 arch/arm/boot/dts/hi4511.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..6e7c1ca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>  	exynos5250-snow.dtb \
>  	exynos5420-smdk5420.dtb \
>  	exynos5440-ssdk5440.dtb
> +dtb-$(CONFIG_ARCH_HI3xxx) += hi4511.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>  	ecx-2000.dtb
>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
> diff --git a/arch/arm/boot/dts/hi3620-clk.dtsi b/arch/arm/boot/dts/hi3620-clk.dtsi
> new file mode 100644
> index 0000000..78307c6
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3620-clk.dtsi
> @@ -0,0 +1,1058 @@
> +/*
> + * Hisilicon Ltd. Hi3620 SoC
> + *
> + * Copyright (C) 2012-2013 Hisilicon Ltd.
> + * Copyright (C) 2012-2013 Linaro Ltd.
> + *
> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * publishhed by the Free Software Foundation.
> + */
> +
> +/ {
> +	clocks {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		osc32k: osc32k {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <32768>;
> +			clock-output-names = "osc32khz";
> +		};

So you've now moved these all under the clocks node, but this still
isn't addressing Stephen's comments about using the
node-name at unit-address and the reg property in each node.

[...]

> +		sysctrl: system-controller at fc802000 {
> +			compatible = "hisilicon,sysctrl";
> +			reg = <0xfc802000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;

Why is sysctrl and all of its children now under the clocks node?


Kevin
