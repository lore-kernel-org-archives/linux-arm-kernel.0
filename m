From: t-kristo@ti.com (Tero Kristo)
Date: Thu, 20 Feb 2014 18:57:12 +0200
Subject: [PATCH 2/2] ARM: dts: OMAP3+: add clock nodes for CPU
In-Reply-To: <1391019557-22313-3-git-send-email-nm@ti.com>
References: <1391019557-22313-1-git-send-email-nm@ti.com>
 <1391019557-22313-3-git-send-email-nm@ti.com>
Message-ID: <530633E8.3000608@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2014 08:19 PM, Nishanth Menon wrote:
> OMAP34xx, AM3517 and OMAP36xx platforms use dpll1 clock.
>
> OMAP443x, OMAP446x, OMAP447x, OMAP5, DRA7, AM43xx platforms use
> dpll_mpu clock.
>
> Latency used is the generic latency defined in omap-cpufreq
> driver.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Looks good to me.

Acked-by: Tero Kristo <t-kristo@ti.com>

> ---
>   arch/arm/boot/dts/am33xx.dtsi |    4 ++++
>   arch/arm/boot/dts/am4372.dtsi |    5 +++++
>   arch/arm/boot/dts/dra7.dtsi   |    5 +++++
>   arch/arm/boot/dts/omap3.dtsi  |    5 +++++
>   arch/arm/boot/dts/omap4.dtsi  |    5 +++++
>   arch/arm/boot/dts/omap5.dtsi  |    6 ++++++
>   6 files changed, 30 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 6d95d3d..4bbba26 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -58,6 +58,10 @@
>   				275000  1125000
>   			>;
>   			voltage-tolerance = <2>; /* 2 percentage */
> +
> +			clocks = <&dpll_mpu_ck>;
> +			clock-names = "cpu";
> +
>   			clock-latency = <300000>; /* From omap-cpufreq driver */
>   		};
>   	};
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index c6bd4d9..33798d9 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -33,6 +33,11 @@
>   			compatible = "arm,cortex-a9";
>   			device_type = "cpu";
>   			reg = <0>;
> +
> +			clocks = <&dpll_mpu_ck>;
> +			clock-names = "cpu";
> +
> +			clock-latency = <300000>; /* From omap-cpufreq driver */
>   		};
>   	};
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 1fd75aa..ce591e5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -47,6 +47,11 @@
>   				1000000	1060000
>   				1176000	1160000
>   				>;
> +
> +			clocks = <&dpll_mpu_ck>;
> +			clock-names = "cpu";
> +
> +			clock-latency = <300000>; /* From omap-cpufreq driver */
>   		};
>   		cpu at 1 {
>   			device_type = "cpu";
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index a5fc83b..01f2b3b 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -35,6 +35,11 @@
>   			compatible = "arm,cortex-a8";
>   			device_type = "cpu";
>   			reg = <0x0>;
> +
> +			clocks = <&dpll1_ck>;
> +			clock-names = "cpu";
> +
> +			clock-latency = <300000>; /* From omap-cpufreq driver */
>   		};
>   	};
>
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index d3f8a6e..ce87996 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -36,6 +36,11 @@
>   			device_type = "cpu";
>   			next-level-cache = <&L2>;
>   			reg = <0x0>;
> +
> +			clocks = <&dpll_mpu_ck>;
> +			clock-names = "cpu";
> +
> +			clock-latency = <300000>; /* From omap-cpufreq driver */
>   		};
>   		cpu at 1 {
>   			compatible = "arm,cortex-a9";
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index a72813a..8bb4134 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -49,6 +49,12 @@
>   				1000000 1060000
>   				1500000 1250000
>   			>;
> +
> +			clocks = <&dpll_mpu_ck>;
> +			clock-names = "cpu";
> +
> +			clock-latency = <300000>; /* From omap-cpufreq driver */
> +
>   			/* cooling options */
>   			cooling-min-level = <0>;
>   			cooling-max-level = <2>;
>
