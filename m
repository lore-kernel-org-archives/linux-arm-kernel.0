From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 16 Mar 2015 09:02:05 +0100
Subject: [PATCH v4 5/5] ARM: dts: Add LEDs to exynos5410-odroidxu
In-Reply-To: <1426456834-6308-6-git-send-email-afaerber@suse.de>
References: <1426456834-6308-1-git-send-email-afaerber@suse.de>
 <1426456834-6308-6-git-send-email-afaerber@suse.de>
Message-ID: <CABxcv=mxrvs4a=WqHLB6V4tBPfnNAaFP_wWJg7GUrTnW-njMFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Andreas,

On Sun, Mar 15, 2015 at 11:00 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3: Unchanged
>
>  v1 -> v2:
>  * Filled in Sob from Hakjoo Kim
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
>         model = "ODROID-XU based on EXYNOS5410";
>         compatible = "hardkernel,odroid-xu", "samsung,exynos5410", "samsung,exynos5";
> @@ -39,6 +40,30 @@
>                 reg = <0x02037000 0x1000>;
>         };
>
> +       leds {
> +               compatible = "gpio-leds";
> +
> +               blue {
> +                       label = "blue:heartbeat";
> +                       gpios = <&gpb2 2 GPIO_ACTIVE_HIGH>;
> +                       default-state = "off";
> +                       linux,default-trigger = "heartbeat";
> +               };
> +
> +               green {
> +                       label = "green:activity";
> +                       gpios = <&gpb2 1 GPIO_ACTIVE_HIGH>;
> +                       default-state = "off";
> +                       linux,default-trigger = "mmc0";
> +               };
> +
> +               red {
> +                       label = "red:activity";
> +                       gpios = <&gpx2 3 GPIO_ACTIVE_HIGH>;
> +                       default-state = "off";
> +                       linux,default-trigger = "mmc1";
> +               };

I see that you are sorting alphabetically using the node name but for
example in pinctrl lines we were sorting using the GPIO bank and
offset so if we want to use the same policy here, this should be
green, blue and red.

Either way is good to me though so is up to you.

Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
