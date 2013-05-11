From: dianders@chromium.org (Doug Anderson)
Date: Sat, 11 May 2013 14:40:34 -0700
Subject: [PATCH] ARM: dts: add pin state information for DP HPD support to
 Exynos5250
In-Reply-To: <000001ce4e1e$d1cc5de0$756519a0$@samsung.com>
References: <000001ce4e1e$d1cc5de0$756519a0$@samsung.com>
Message-ID: <CAD=FV=V9oBR1ZAEsMs5-x7NaD1fiHJO=9dn1mPAMg0MX6tnxYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jingoo,

On Sat, May 11, 2013 at 1:09 AM, Jingoo Han <jg1.han@samsung.com> wrote:
> Add pin state information for DP HPD support that requires
> pin configuration support using pinctrl interface.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
> Tested on Exynos5250
>
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi |    7 +++++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |    3 +++
>  2 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> index d1650fb..e9cdee3 100644
> --- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
> @@ -553,6 +553,13 @@
>                         samsung,pin-pud = <0>;
>                         samaung,pin-drv = <0>;
>                 };
> +
> +               dp_hpd: dp_hpd {
> +                       samsung,pins = "gpx0-7";
> +                       samsung,pin-function = <3>;
> +                       samsung,pin-pud = <0>;
> +                       samaung,pin-drv = <0>;
> +               };
>         };
>
>         pinctrl at 13400000 {
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 3e0c792..d53ea34 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -224,6 +224,9 @@
>                 samsung,color-depth = <1>;
>                 samsung,link-rate = <0x0a>;
>                 samsung,lane-count = <4>;
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&dp_hpd>;

I was going to suggest moving this to exynos5250.dtsi but then
realized that I saw a board recently that used a non-standard HPD pin
recently!  ...so keeping it in the board file (like you've done) is
good.

...so looks good to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>
