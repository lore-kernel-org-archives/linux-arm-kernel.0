From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Mar 2013 10:02:24 -0700
Subject: [PATCH 2/2] ARM: dts: add pin state information in client nodes
 for Exynos5 platforms
In-Reply-To: <1362573398-15126-3-git-send-email-thomas.abraham@linaro.org>
References: <1362573398-15126-1-git-send-email-thomas.abraham@linaro.org>
 <1362573398-15126-3-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAD=FV=Vrv1bvF0rbNkAvbX0dkJ1GxrRUUBNvHmLcWd45omRBag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Thank you for doing this!  :)

On Wed, Mar 6, 2013 at 4:36 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:>

> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 17dd951..434e440 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -35,9 +50,8 @@
>          */
>         dwmmc3 at 12230000 {
>                 slot at 0 {
> -                       gpios = <&gpc4 0 2 0 0>, <&gpc4 1 2 3 0>,
> -                               <&gpc4 3 2 3 0>, <&gpc4 4 2 3 0>,
> -                               <&gpc4 5 2 3 0>, <&gpc4 6 2 3 0>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;

nit: Move comment about EMI to the "pinctrl at 11400000" that you added
earlier in this file.  ...then move the pinctrl-names and pinctrl-0 to
"cros5250.dtsi".  This is not major and could be done in a follow-up
patch.


I done basic testing of this patch series on exynos5250-snow atop
linux-next 20130307.  By series I mean these patchwork IDs:

2224531 New          mmc: sdhci-s3c: let device core setup the default
pin configuration
2224621 New          spi: s3c64xx: let device core setup the default
pin configuration
2224731 New          input: samsung-keypad: let device core setup the
default pin configuration
2224801 New          ASoC: samsung: let device core setup the default
pin configuration
2224851 New          mmc: dwmmc: let device core setup the default pin
configuration
2225141 New          [1/2] ARM: dts: add pin state information in
client nodes for Exynos4 platforms
2225151 New          [2/2] ARM: dts: add pin state information in
client nodes for Exynos5 platforms

Tested-by: Doug Anderson <dianders@chromium.org>


This patch looks good to me with or without the above nit fix.

Reviewed-by: Doug Anderson <dianders@chromium.org>
