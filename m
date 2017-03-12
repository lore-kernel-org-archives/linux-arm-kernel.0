From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 12 Mar 2017 13:50:42 -0700
Subject: [PATCH v2 6/8] ARM: dts: exynos: Fix infinite interrupt in soft
 mode on Exynos4210 and Exynos5440
In-Reply-To: <20170311172527.16368-7-krzk@kernel.org>
References: <20170311172527.16368-1-krzk@kernel.org>
 <20170311172527.16368-7-krzk@kernel.org>
Message-ID: <cd593e3b-79ca-0813-b2c1-10e2ae3aab63@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2017 09:25 AM, Krzysztof Kozlowski wrote:
> In soft (no-reboot) mode, the driver self-pings watchdog upon expiration
> of an interrupt.  The interrupt has to be cleared, because otherwise
> system enters infinite interrupt handling loop.
>
> Use a samsung,s3c6410-wdt compatible to select appropriate quirk for
> clearing the watchdog interrupt.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 2 +-
>  arch/arm/boot/dts/exynos5440.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 9d51d4d62d94..e6e62103a71f 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -120,7 +120,7 @@
>  	};
>
>  	watchdog: watchdog at 10060000 {
> -		compatible = "samsung,s3c2410-wdt";
> +		compatible = "samsung,s3c6410-wdt";
>  		reg = <0x10060000 0x100>;
>  		interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&clock CLK_WDT>;
> diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> index 77d35bb92950..abfe054b2187 100644
> --- a/arch/arm/boot/dts/exynos5440.dtsi
> +++ b/arch/arm/boot/dts/exynos5440.dtsi
> @@ -189,7 +189,7 @@
>  	};
>
>  	watchdog at 110000 {
> -		compatible = "samsung,s3c2410-wdt";
> +		compatible = "samsung,s3c6410-wdt";
>  		reg = <0x110000 0x1000>;
>  		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&clock CLK_B_125>;
>
