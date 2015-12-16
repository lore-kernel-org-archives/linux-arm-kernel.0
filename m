From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 17 Dec 2015 08:49:35 +0900
Subject: [PATCH 12/19] ARM: dts: exynos: replace legacy *, wakeup property
 with wakeup-source
In-Reply-To: <1445422216-29375-13-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
 <1445422216-29375-13-git-send-email-sudeep.holla@arm.com>
Message-ID: <5671F88F.7050802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.10.2015 19:10, Sudeep Holla wrote:
> Though the keyboard and other driver will continue to support the legacy
> "gpio-key,wakeup", "linux-keypad,wakeup" boolean property to enable the
> wakeup source, "wakeup-source" is the new standard binding.
> 
> This patch replaces all the legacy wakeup properties with the unified
> "wakeup-source" property in order to avoid any futher copy-paste
> duplication.
> 
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm/boot/dts/exynos3250-monk.dts           |  6 +++---
>  arch/arm/boot/dts/exynos3250-rinato.dts         |  6 +++---
>  arch/arm/boot/dts/exynos4210-origen.dts         | 10 +++++-----
>  arch/arm/boot/dts/exynos4210-smdkv310.dts       |  2 +-
>  arch/arm/boot/dts/exynos4210-trats.dts          |  2 +-
>  arch/arm/boot/dts/exynos4210-universal_c210.dts |  4 ++--
>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |  2 +-
>  arch/arm/boot/dts/exynos4412-odroidx.dts        |  2 +-
>  arch/arm/boot/dts/exynos4412-origen.dts         |  2 +-
>  arch/arm/boot/dts/exynos4412-smdk4412.dts       |  2 +-
>  arch/arm/boot/dts/exynos4412-trats2.dts         |  4 ++--
>  arch/arm/boot/dts/exynos5250-arndale.dts        | 12 ++++++------
>  arch/arm/boot/dts/exynos5250-snow.dts           |  4 ++--
>  arch/arm/boot/dts/exynos5250-spring.dts         |  4 ++--
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts   |  2 +-
>  arch/arm/boot/dts/exynos5420-peach-pit.dts      |  4 ++--
>  arch/arm/boot/dts/exynos5800-peach-pi.dts       |  4 ++--
>  17 files changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos3250-monk.dts b/arch/arm/boot/dts/exynos3250-monk.dts
> index 540a0adf2be6..b77ea2163a0a 100644
> --- a/arch/arm/boot/dts/exynos3250-monk.dts
> +++ b/arch/arm/boot/dts/exynos3250-monk.dts
> @@ -43,7 +43,7 @@
>  			linux,code = <KEY_POWER>;
>  			label = "power key";
>  			debounce-interval = <10>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> @@ -67,7 +67,7 @@
>  			interrupt-parent = <&gpx1>;
>  			interrupts = <5 0>;
>  			reg = <0x25>;
> -			wakeup;
> +			wakeup-source;
>  
>  			muic: max77836-muic {
>  				compatible = "maxim,max77836-muic";
> @@ -184,7 +184,7 @@
>  		interrupt-parent = <&gpx0>;
>  		interrupts = <7 0>;
>  		reg = <0x66>;
> -		wakeup;
> +		wakeup-source;
>  
>  		s2mps14_osc: clocks {
>  			compatible = "samsung,s2mps14-clk";
> diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
> index 41a5fafb9aa9..7acd11d2d957 100644
> --- a/arch/arm/boot/dts/exynos3250-rinato.dts
> +++ b/arch/arm/boot/dts/exynos3250-rinato.dts
> @@ -43,7 +43,7 @@
>  			linux,code = <KEY_POWER>;
>  			label = "power key";
>  			debounce-interval = <10>;
> -			gpio-key,wakeup;
> +			wakeup-source;
>  		};
>  	};
>  
> @@ -58,7 +58,7 @@
>  			interrupt-parent = <&gpx1>;
>  			interrupts = <5 0>;
>  			reg = <0x25>;
> -			wakeup;
> +			wakeup-source;
>  
>  			muic: max77836-muic {
>  				compatible = "maxim,max77836-muic";
> @@ -245,7 +245,7 @@
>  		interrupt-parent = <&gpx0>;
>  		interrupts = <7 0>;
>  		reg = <0x66>;
> -		wakeup;
> +		wakeup-source;

I think here and in Monk board these four "wakeup" properties are bogus,
not parsed by driver. Instead wakeup is always initialized to true.

Anyway fixing this is not part of this patch but instead this should be
fixed in separate commit. Here everything looks good:

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
