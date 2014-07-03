From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 03 Jul 2014 14:44:17 +0200
Subject: [PATCH 11/17] pwm: samsung: remove s5pc100 related pwm codes
In-Reply-To: <1404163947-3105-12-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-12-git-send-email-kgene.kim@samsung.com>
Message-ID: <53B55021.9020307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 30.06.2014 23:32, Kukjin Kim wrote:
> This patch removes supporting s5pc100 related pwm codes.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-samsung.txt |    2 --
>  drivers/clocksource/samsung_pwm_timer.c               |   12 ------------
>  drivers/pwm/pwm-samsung.c                             |    8 --------
>  3 files changed, 22 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> index 43925d3..82c7f6b 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-samsung.txt
> @@ -11,8 +11,6 @@ Required properties:
>  - compatible : should be one of following:
>      samsung,s3c2410-pwm - for 16-bit timers present on S3C24xx SoCs
>      samsung,s3c6400-pwm - for 32-bit timers present on S3C64xx SoCs
> -    samsung,s5pc100-pwm - for 32-bit timers present on S5PC100, S5PV210,
> -			  Exynos4210 rev0 SoCs

As you can see here, this variant is used for more than S5PC100. It is
needed for S5PV210 and Exynos4210 rev0 SoCs as well. So this patch
should be dropped.

Best regards,
Tomasz
