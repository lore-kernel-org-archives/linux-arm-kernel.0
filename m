From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 08 Feb 2013 14:44:05 -0800
Subject: [PATCH RESEND v2] ARM: EXYNOS: dts: Set up power domain for MFC
 and G-scaler
In-Reply-To: <1359521344-17189-1-git-send-email-prasanna.ps@samsung.com>
References: <06e301cdfe51$f11b59c0$d3520d40$@samsung.com>
 <1359521344-17189-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <1a5801ce064d$cddb41b0$6991c510$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prasanna Kumar wrote:
> 
> This patch adds device tree nodes for MFC and G-scaler power
> domains of exynos5250.It binds these power-domain nodes to repsective
> device tree nodes
> 
> It also adds support to enable PM generic domains for exynos5250.
> 
> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |   16 ++++++++++++++++
>  arch/arm/mach-exynos/Kconfig      |    1 +
>  2 files changed, 17 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 30485de..e282fde 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -46,6 +46,16 @@
>  		i2c8 = &i2c_8;
>  	};
> 
> +	pd_gsc: gsc-power-domain at 0x10044000 {
> +		compatible = "samsung,exynos4210-pd";
> +		reg = <0x10044000 0x20>;
> +	};
> +
> +	pd_mfc: mfc-power-domain at 0x10044040 {
> +		compatible = "samsung,exynos4210-pd";
> +		reg = <0x10044040 0x20>;
> +	};
> +
>  	gic:interrupt-controller at 10481000 {
>  		compatible = "arm,cortex-a9-gic";
>  		#interrupt-cells = <3>;
> @@ -85,6 +95,7 @@
>  		compatible = "samsung,mfc-v6";
>  		reg = <0x11000000 0x10000>;
>  		interrupts = <0 96 0>;
> +		samsung,power-domain = <&pd_mfc>;
>  	};
> 
>  	rtc {
> @@ -554,28 +565,33 @@
>  		};
>  	};
> 
> +
>  	gsc_0:  gsc at 0x13e00000 {
>  		compatible = "samsung,exynos5-gsc";
>  		reg = <0x13e00000 0x1000>;
>  		interrupts = <0 85 0>;
> +		samsung,power-domain = <&pd_gsc>;
>  	};
> 
>  	gsc_1:  gsc at 0x13e10000 {
>  		compatible = "samsung,exynos5-gsc";
>  		reg = <0x13e10000 0x1000>;
>  		interrupts = <0 86 0>;
> +		samsung,power-domain = <&pd_gsc>;
>  	};
> 
>  	gsc_2:  gsc at 0x13e20000 {
>  		compatible = "samsung,exynos5-gsc";
>  		reg = <0x13e20000 0x1000>;
>  		interrupts = <0 87 0>;
> +		samsung,power-domain = <&pd_gsc>;
>  	};
> 
>  	gsc_3:  gsc at 0x13e30000 {
>  		compatible = "samsung,exynos5-gsc";
>  		reg = <0x13e30000 0x1000>;
>  		interrupts = <0 88 0>;
> +		samsung,power-domain = <&pd_gsc>;
>  	};
> 
>  	hdmi {
> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-
> exynos/Kconfig
> index e103c29..96f4a9f 100644
> --- a/arch/arm/mach-exynos/Kconfig
> +++ b/arch/arm/mach-exynos/Kconfig
> @@ -61,6 +61,7 @@ config SOC_EXYNOS5250
>  	bool "SAMSUNG EXYNOS5250"
>  	default y
>  	depends on ARCH_EXYNOS5
> +	select PM_GENERIC_DOMAINS if PM
>  	select S5P_PM if PM
>  	select S5P_SLEEP if PM
>  	select S5P_DEV_MFC
> --
> 1.7.5.4

Looks OK to me, applied.

Thanks.

- Kukjin
