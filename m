From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 17 Aug 2016 11:25:06 +0100
Subject: [PATCH] ARM: dts: exynos: Use stdout non-deprecated property and
 add serial options to Odroid XU/XU3/XU4
In-Reply-To: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
References: <1471419298-10414-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20160817102506.GD30900@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2016 at 09:34:58AM +0200, Krzysztof Kozlowski wrote:
> The "linux,stdout-path" is deprecated.
> 
> Add serial options so the console can be properly configured when
> bootloader does not pass "console" parameter to command line.  Without
> options and lack of "console", the serial output dies during boot (just
> after probing sound).

I'm confused. Is this just a cleanup (given "linux,stdout-path" is
deprecated but still supported), or a bug fix?

I guess that prior to this patch Linux might change the rate of the
console, but otherwise it should work.

Mark.

> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          | 2 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index f6d135245a4b..a5ae76c1838f 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -26,7 +26,7 @@
>  	};
>  
>  	chosen {
> -		linux,stdout-path = &serial_2;
> +		stdout-path = "serial2:115200n8";
>  	};
>  
>  	emmc_pwrseq: pwrseq {
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index d56253049ccb..d04490d40b07 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -26,7 +26,7 @@
>  	};
>  
>  	chosen {
> -		linux,stdout-path = &serial_2;
> +		stdout-path = "serial2:115200n8";
>  	};
>  
>  	firmware at 02073000 {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
