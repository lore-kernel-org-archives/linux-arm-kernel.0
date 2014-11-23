From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sun, 23 Nov 2014 02:31:31 +0100
Subject: [PATCH v2 5/5] ARM: dts: exynos5410: Add ODROID-XU LEDs
In-Reply-To: <1416687984-3546-6-git-send-email-afaerber@suse.de>
References: <1416687984-3546-1-git-send-email-afaerber@suse.de>
 <1416687984-3546-6-git-send-email-afaerber@suse.de>
Message-ID: <547138F3.3040502@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Hakjoo,

Am 22.11.2014 um 21:26 schrieb Andreas F?rber:
> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>

Sorry, I was too quick here: Only the previous two patches got signed
off by you, plus the last one on your 3.14 branch. Are you able to sign
off all patches authored by you there? (An email reply indicating the
Signed-off-by should do, if updating the branch is too much work.)

Thanks,
Andreas

> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
> v1 -> v2:
> * Filled in Sob from Hakjoo Kim
> 
>  arch/arm/boot/dts/exynos5410-odroidxu.dts | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index 97310bb727e2..b02cd3ab7b38 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -15,6 +15,7 @@
>  
>  /dts-v1/;
>  #include "exynos5410.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  / {
>  	model = "ODROID-XU based on EXYNOS5410";
>  	compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
> @@ -39,6 +40,30 @@
>  		reg = <0x02037000 0x1000>;
>  	};
>  
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		blue {
> +			label = "blue:heartbeat";
> +			gpios = <&gpb2 2 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		green {
> +			label = "green:activity";
> +			gpios = <&gpb2 1 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "mmc0";
> +		};
> +
> +		red {
> +			label = "red:activity";
> +			gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
> +			default-state = "off";
> +			linux,default-trigger = "mmc1";
> +		};
> +	};
>  };
>  
>  &mmc_0 {
> 


-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
