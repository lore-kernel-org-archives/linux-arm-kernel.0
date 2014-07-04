From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 04 Jul 2014 10:10:50 +0200
Subject: [PATCH 05/17] pwm: samsung: remove s5p64x0 related pwm codes
In-Reply-To: <1404163947-3105-6-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-6-git-send-email-kgene.kim@samsung.com>
Message-ID: <53B6618A.3050504@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 30.06.2014 23:32, Kukjin Kim wrote:
> This patch removes supporting s5p64x0 related pwm codes because of
> no more support for S5P6440 and S5P6450 SoCs. And this patch changes
> the name of s5p6440-pwm to exynos-pwm instead.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt |    1 -
>  arch/arm/boot/dts/exynos4210-universal_c210.dts       |    2 +-
>  drivers/clocksource/samsung_pwm_timer.c               |   13 -------------
>  drivers/pwm/pwm-samsung.c                             |    5 ++---
>  4 files changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> index 5538de9..43925d3 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> @@ -11,7 +11,6 @@ Required properties:
>  - compatible : should be one of following:
>      samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
>      samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
> -    samsung,s5p6440-pwm - for 32-bit timers present on S5P64x0 SoCs
>      samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
>  			  Exynos4210 rev0 SoCs
>      samsung,exynos4210-pwm - for 32-bit timers present on Exynos4210,
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index d50eb3a..0ca26e0 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -461,7 +461,7 @@
>  	};
>  
>  	pwm at 139D0000 {
> -		compatible = "samsung,s5p6440-pwm";
> +		compatible = "samsung,exynos4210-pwm";

There is a reason to use a different compatible string for Exynos4210
rev0. The PWM block is used as a timer there, while on newer revs MCT is
used. Sorry, but I have to NAK this patch.

As I explained in my reply to patch 11/17, I'd suggest keeping the PWM
drivers as is, because there is no need to remove support for DT
compatible strings.

Best regards,
Tomasz
