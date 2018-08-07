From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 7 Aug 2018 12:59:48 +0200
Subject: [RFT 4/4] ARM: dts: exynos: Add LDO28 regulator on Exynos5422
 Odroid boards
In-Reply-To: <20180806160933.6578-4-krzk@kernel.org>
References: <20180806160933.6578-1-krzk@kernel.org>
 <CGME20180806160955epcas4p14c924297f156db1dcb30ce543bc2d79a@epcas4p1.samsung.com>
 <20180806160933.6578-4-krzk@kernel.org>
Message-ID: <20180807105950eucas1p1e48a3d064afb4d601fa33eeb67f0ba02~IlRTyxXuT0840608406eucas1p1t@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018-08-06 18:09, Krzysztof Kozlowski wrote:
> The LDO28 is used only on Odroid XU3 for Display Port.  Define it so DTS
> will describe entire hardware.
>
> Depending on bootloader behavior this might affect the Display Port
> because none of drivers are enabling it. By default it is off in S2MPS11
> PMIC reset values.  However it could be enabled by bootloader so in such
> case kernel will later disable it as unused regulator.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Odroid XU3 boots fine with this patch. Display Port is not yet enabled in
mainline for OdroidXU3, so there is not much else to test for now.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

> ---
>
> Not tested on Odroid XU3 with Display Port.
> ---
>   arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 7 +++++++
>   arch/arm/boot/dts/exynos5422-odroidxu3.dts    | 6 ++++++
>   2 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> index b0dc9cc81b94..178e1064cfc7 100644
> --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> @@ -331,6 +331,13 @@
>   				regulator-always-on;
>   			};
>   
> +			ldo28_reg: LDO28 {
> +				/* Used on XU3 */
> +				regulator-name = "vdd_ldo26";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +			};
> +
>   			ldo29_reg: LDO29 {
>   				/* Unused */
>   				regulator-name = "vdd_ldo29";
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3.dts b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> index 0322f281912c..db0bc17a667b 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3.dts
> @@ -49,6 +49,12 @@
>   	};
>   };
>   
> +&ldo28_reg {
> +	regulator-name = "dp_p3v3";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +};
> +
>   &pwm {
>   	/*
>   	 * PWM 0 -- fan

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
