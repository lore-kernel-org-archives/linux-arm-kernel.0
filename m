From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 24 Apr 2014 19:04:22 +0200
Subject: [PATCH] ARM: dts: exynos4: clean up arm-pmu node
In-Reply-To: <1397480584-16195-1-git-send-email-chanho61.park@samsung.com>
References: <1397480584-16195-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <53594416.4070601@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

On 14.04.2014 15:03, Chanho Park wrote:
> This patch cleans a arm-pmu node up for exynos4. Only exynos4412 series
> boards have four pmu interrupts. Rest of exynos4 boards, except 4412, have only
> two pmu interrupts. Thus, we can define two interrupts in the
> exynos4.dtsi and extends the interrupts only exynos4412.dtsi.
>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4.dtsi    | 6 ++++++
>   arch/arm/boot/dts/exynos4210.dtsi | 6 ------
>   arch/arm/boot/dts/exynos4412.dtsi | 6 ++++++
>   arch/arm/boot/dts/exynos4x12.dtsi | 6 ------
>   4 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index e541ecb..6de978c 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -105,6 +105,12 @@
>   		reg = <0x10440000 0x1000>;
>   	};
>
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 2>, <3 2>;
> +	};
> +
>   	sys_reg: syscon at 10010000 {
>   		compatible = "samsung,exynos4-sysreg", "syscon";
>   		reg = <0x10010000 0x400>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index cacf614..4e7610f 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -75,12 +75,6 @@
>   		#clock-cells = <1>;
>   	};
>
> -	pmu {
> -		compatible = "arm,cortex-a9-pmu";
> -		interrupt-parent = <&combiner>;
> -		interrupts = <2 2>, <3 2>;
> -	};
> -
>   	pinctrl_0: pinctrl at 11400000 {
>   		compatible = "samsung,exynos4210-pinctrl";
>   		reg = <0x11400000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 15d3c0a..e6af870 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -26,6 +26,12 @@
>   		samsung,combiner-nr = <20>;
>   	};
>
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;

I guess you could omit the two properties above and let them be 
inherited from exynos4.dtsi.

Otherwise looks fine.

Best regards,
Tomasz
