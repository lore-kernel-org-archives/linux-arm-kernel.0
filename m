From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 29 Jan 2013 10:53:33 -0800
Subject: [PATCH RESEND] ARM: EXYNOS: dts: Set up power domain for MFC and
 G-scaler
In-Reply-To: <1359453320-14911-1-git-send-email-prasanna.ps@samsung.com>
References: <05b901cdfde0$a373a860$ea5af920$@samsung.com>
 <1359453320-14911-1-git-send-email-prasanna.ps@samsung.com>
Message-ID: <06e301cdfe51$f11b59c0$d3520d40$@samsung.com>
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
>  arch/arm/boot/dts/exynos5250.dtsi |   15 +++++++++++++++
>  arch/arm/mach-exynos/Kconfig      |    1 +
>  2 files changed, 16 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index 30485de..6d0e87c 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -85,6 +85,7 @@
>  		compatible = "samsung,mfc-v6";
>  		reg = <0x11000000 0x10000>;
>  		interrupts = <0 96 0>;
> +		samsung,power-domain = <&pd_mfc>;
>  	};
> 
>  	rtc {
> @@ -554,28 +555,42 @@
>  		};
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

Please put the above nodes by order of address.

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
