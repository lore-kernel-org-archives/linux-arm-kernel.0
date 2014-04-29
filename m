From: tushar.behera@linaro.org (Tushar Behera)
Date: Tue, 29 Apr 2014 12:21:46 +0530
Subject: [PATCHv2] ARM: dts: exynos4: clean up arm-pmu node
In-Reply-To: <1398391553-4797-1-git-send-email-chanho61.park@samsung.com>
References: <1398391553-4797-1-git-send-email-chanho61.park@samsung.com>
Message-ID: <535F4C02.6040204@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 07:35 AM, Chanho Park wrote:
> This patch cleans a arm-pmu node up for exynos4. Only exynos4412 series
> boards have four pmu interrupts. Rest of exynos4 boards, except 4412, have only
> two pmu interrupts. Thus, we can define two interrupts in the
> exynos4.dtsi and extends the interrupts only exynos4412.dtsi.
> 
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---

Tested on Exynos4210 based Origen and Exynos4412 based Origenquad boards.

Tested-by: Tushar Behera <tushar.behera@linaro.org>

> Changes from v1:
>  - Remove duplicated properties in exynos4412.dtsi(Comment from Tomasz Figa)
> 
>  arch/arm/boot/dts/exynos4.dtsi    | 6 ++++++
>  arch/arm/boot/dts/exynos4210.dtsi | 6 ------
>  arch/arm/boot/dts/exynos4412.dtsi | 4 ++++
>  arch/arm/boot/dts/exynos4x12.dtsi | 6 ------
>  4 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index 0401f4d..b43dc24 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -105,6 +105,12 @@
>  		reg = <0x10440000 0x1000>;
>  	};
>  
> +	pmu {
> +		compatible = "arm,cortex-a9-pmu";
> +		interrupt-parent = <&combiner>;
> +		interrupts = <2 2>, <3 2>;
> +	};
> +
>  	sys_reg: syscon at 10010000 {
>  		compatible = "samsung,exynos4-sysreg", "syscon";
>  		reg = <0x10010000 0x400>;
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index cb0e768d..e19c154 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -75,12 +75,6 @@
>  		#clock-cells = <1>;
>  	};
>  
> -	pmu {
> -		compatible = "arm,cortex-a9-pmu";
> -		interrupt-parent = <&combiner>;
> -		interrupts = <2 2>, <3 2>;
> -	};
> -
>  	pinctrl_0: pinctrl at 11400000 {
>  		compatible = "samsung,exynos4210-pinctrl";
>  		reg = <0x11400000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index a40b6e2..7b75762 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -26,6 +26,10 @@
>  		samsung,combiner-nr = <20>;
>  	};
>  
> +	pmu {
> +		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
> +	};
> +
>  	gic: interrupt-controller at 10490000 {
>  		cpu-offset = <0x4000>;
>  	};
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index c4a9306..b730a74 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -31,12 +31,6 @@
>  		mshc0 = &mshc_0;
>  	};
>  
> -	pmu {
> -		compatible = "arm,cortex-a9-pmu";
> -		interrupt-parent = <&combiner>;
> -		interrupts = <2 2>, <3 2>, <18 2>, <19 2>;
> -	};
> -
>  	pd_isp: isp-power-domain at 10023CA0 {
>  		compatible = "samsung,exynos4210-pd";
>  		reg = <0x10023CA0 0x20>;
> 


-- 
Tushar Behera
