From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 27 Nov 2017 18:47:07 +0100
Subject: [PATCH] ARM: dts: exynos: fix property values of LDO15/17 for
 ODROID-XU3/4
In-Reply-To: <20171028173329.15368-1-tobetter@gmail.com>
References: <20171028173329.15368-1-tobetter@gmail.com>
Message-ID: <20171127174707.34kgjdggqo3qhs7b@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 28, 2017 at 01:32:48PM -0400, tobetter at gmail.com wrote:
> From: Dongjin Kim <tobetter@gmail.com>
> 
> Looking at the schematic, LDO15 and LDO17 are tied as a power source of a
> builtin network chipset. The voltage on LDO15 is corrected to 3.3V and the
> name of LDO17 is corrected to "vdd_ldo17".
> 
> Signed-off-by: Dongjin Kim <tobetter@gmail.com>
> ---
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Patch does not apply on top of v4.15-rc1. Please rebase on v4.15-rc1 (or
on my next/dt branch).

Best regards,
Krzysztof

> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index a183b56283f8..68780569371d 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -372,8 +372,8 @@
>  
>  			ldo15_reg: LDO15 {
>  				regulator-name = "vdd_ldo15";
> -				regulator-min-microvolt = <3100000>;
> -				regulator-max-microvolt = <3100000>;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  			};
>  
> @@ -385,7 +385,7 @@
>  			};
>  
>  			ldo17_reg: LDO17 {
> -				regulator-name = "tsp_avdd";
> +				regulator-name = "vdd_ldo17";
>  				regulator-min-microvolt = <3300000>;
>  				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
> -- 
> 2.11.0
> 
