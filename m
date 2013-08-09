From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Aug 2013 16:25:02 +0100
Subject: [PATCH v6 4/4] ARM: hi3xxx: enable hi4511 with device tree
In-Reply-To: <1374813135-16238-5-git-send-email-haojian.zhuang@linaro.org>
References: <1374813135-16238-1-git-send-email-haojian.zhuang@linaro.org>
 <1374813135-16238-5-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20130809152502.GS27325@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 05:32:15AM +0100, Haojian Zhuang wrote:
> Enable Hisilicon Hi4511 development platform with device tree support.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile          |    1 +
>  arch/arm/boot/dts/hi3620.dtsi       | 1147 +++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/hi4511.dts        |  648 ++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig |    1 +
>  4 files changed, 1797 insertions(+)
>  create mode 100644 arch/arm/boot/dts/hi3620.dtsi
>  create mode 100644 arch/arm/boot/dts/hi4511.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 641b3c9..6e7c1ca 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -61,6 +61,7 @@ dtb-$(CONFIG_ARCH_EXYNOS) += exynos4210-origen.dtb \
>         exynos5250-snow.dtb \
>         exynos5420-smdk5420.dtb \
>         exynos5440-ssdk5440.dtb
> +dtb-$(CONFIG_ARCH_HI3xxx) += hi4511.dtb
>  dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>         ecx-2000.dtb
>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
> diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
> new file mode 100644
> index 0000000..aca09ad
> --- /dev/null
> +++ b/arch/arm/boot/dts/hi3620.dtsi
> @@ -0,0 +1,1147 @@
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
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +       aliases {
> +               serial0 = &uart0;
> +               serial1 = &uart1;
> +               serial2 = &uart2;
> +               serial3 = &uart3;
> +               serial4 = &uart4;
> +       };

Missing /cpus/cpu at N nodes.

> +
> +       osc32k: osc at 0 {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               clock-frequency = <32768>;
> +               clock-output-names = "osc32khz";
> +       };

As these don't have reg values, the unit-address (the @N) should
disappear, each node can simply be given a unique name.

Thanks,
Mark.
