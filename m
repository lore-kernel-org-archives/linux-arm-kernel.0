From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 8 Sep 2017 12:33:29 +0100
Subject: [PATCH v3 2/6] ARM: dts: exynos: Add clean name of compatible.
In-Reply-To: <1504850560-27950-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1504850560-27950-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170908060308epcas1p2b275c76f63f5742092a7bc4ef14c05a5@epcas1p2.samsung.com>
 <1504850560-27950-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <1a2dfeb9-b2e1-3bc6-772a-e3b55fc51b7f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/17 07:02, Hoegeun Kwon wrote:
> Exynos 5250 and 5420 have different hardware rotation limits. However,
> currently it uses only one compatible - "exynos5-gsc". Since we have
> to distinguish between these two, we add different compatible.
> 
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 8 ++++----
>  arch/arm/boot/dts/exynos5420.dtsi | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 8dbeb87..bf08101 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -637,7 +637,7 @@
>  		};
>  
>  		gsc_0:  gsc at 13e00000 {
> -			compatible = "samsung,exynos5-gsc";
> +			compatible = "samsung,exynos5-gsc", "samsung,exynos5250-gsc";

These should be the other way round - the most specific compatible
should come first, then the more general fallback afterwards.

(and similarly in all cases below)

Robin.

>  			reg = <0x13e00000 0x1000>;
>  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>  			power-domains = <&pd_gsc>;
> @@ -647,7 +647,7 @@
>  		};
>  
>  		gsc_1:  gsc at 13e10000 {
> -			compatible = "samsung,exynos5-gsc";
> +			compatible = "samsung,exynos5-gsc", "samsung,exynos5250-gsc";
>  			reg = <0x13e10000 0x1000>;
>  			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>  			power-domains = <&pd_gsc>;
> @@ -657,7 +657,7 @@
>  		};
>  
>  		gsc_2:  gsc at 13e20000 {
> -			compatible = "samsung,exynos5-gsc";
> +			compatible = "samsung,exynos5-gsc", "samsung,exynos5250-gsc";
>  			reg = <0x13e20000 0x1000>;
>  			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
>  			power-domains = <&pd_gsc>;
> @@ -667,7 +667,7 @@
>  		};
>  
>  		gsc_3:  gsc at 13e30000 {
> -			compatible = "samsung,exynos5-gsc";
> +			compatible = "samsung,exynos5-gsc", "samsung,exynos5250-gsc";
>  			reg = <0x13e30000 0x1000>;
>  			interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
>  			power-domains = <&pd_gsc>;
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 02d2f89..86afe77 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -658,7 +658,7 @@
>  		};
>  
>  		gsc_0: video-scaler at 13e00000 {
> -			compatible = "samsung,exynos5-gsc";
> +			compatible = "samsung,exynos5-gsc", "samsung,exynos5420-gsc";
>  			reg = <0x13e00000 0x1000>;
>  			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clock CLK_GSCL0>;
> @@ -668,7 +668,7 @@
>  		};
>  
>  		gsc_1: video-scaler at 13e10000 {
> -			compatible = "samsung,exynos5-gsc";
> +			compatible = "samsung,exynos5-gsc", "samsung,exynos5420-gsc";
>  			reg = <0x13e10000 0x1000>;
>  			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clock CLK_GSCL1>;
> 
