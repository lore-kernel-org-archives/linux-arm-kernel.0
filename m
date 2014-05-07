From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 7 May 2014 19:06:45 +0530
Subject: [PATCH 3/5] ARM: dts: enable dp-controller for exynos5250 based
 snow board
In-Reply-To: <1397994525-18537-4-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
 <1397994525-18537-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAPdUM4PLdY+qQF3zs2CYF9SP8E2W4sDESD6jYD9uF+WwhVX3pg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

The only dependency for this patch is new property "samsung,hpd-gpio" which
is acked by Jingoo Han, Maintainer, exynos DP at
http://oascentral.opensubscriber.com/message/dri-devel at lists.freedesktop.org/17150750.html.

All remaining properties are as per existing DT bindings.

@Jingoo, I want to request you to review the dp-controller nodes for
exynos5420 and 5250.

Please consider it for merge.

Regards,
Rahul Sharma.

On 20 April 2014 17:18, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>
> Ennable dp-controller for snow board.
>
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250-snow.dts |   27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index 09f363d..60cc2a8 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -344,6 +344,33 @@
>                 };
>         };
>
> +       dp-controller at 145B0000 {
> +               status = "okay";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&dp_hpd>;
> +               samsung,color-space = <0>;
> +               samsung,dynamic-range = <0>;
> +               samsung,ycbcr-coeff = <0>;
> +               samsung,color-depth = <1>;
> +               samsung,link-rate = <0x0a>;
> +               samsung,lane-count = <2>;
> +               samsung,hpd-gpio = <&gpx0 7 0>;
> +               display-timings {
> +                       native-mode = <&timing1>;
> +                       timing1: timing at 1 {
> +                               clock-frequency = <70589280>;
> +                               hactive = <1366>;
> +                               vactive = <768>;
> +                               hfront-porch = <40>;
> +                               hback-porch = <40>;
> +                               hsync-len = <32>;
> +                               vback-porch = <10>;
> +                               vfront-porch = <12>;
> +                               vsync-len = <6>;
> +                       };
> +               };
> +       };
> +
>         fimd at 14400000 {
>                 status = "okay";
>                 samsung,invert-vclk;
> --
> 1.7.9.5
>
