From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 7 May 2014 19:11:36 +0530
Subject: [PATCH 5/5] ARM: dts: enable dp-controller for exynos5420 based
 peach-pit board
In-Reply-To: <1397994525-18537-6-git-send-email-rahul.sharma@samsung.com>
References: <1397994525-18537-1-git-send-email-rahul.sharma@samsung.com>
 <1397994525-18537-6-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAPdUM4PZLAOfdtH8xO9C4x0CKhWmX2PstqNkAE2cffTnn45VfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

I have same update for this patch. The new DT property is Acked at
http://oascentral.opensubscriber.com/message/dri-devel at lists.freedesktop.org/17150750.html

Please consider it for merge.

Regards,
Rahul Sharma.

On 20 April 2014 17:18, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>
> Enable dp-controller for peach-pit board.
>
> Signed-off-by: Rahul Sharma <Rahul.Sharma@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   34 ++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index d6eaa1f..e6199e1 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -61,6 +61,13 @@
>                         samsung,pin-pud = <1>;
>                         samsung,pin-drv = <0>;
>                 };
> +
> +               dp_hpd: dp_hpd {
> +                       samsung,pins = "gpx2-6";
> +                       samsung,pin-function = <0>;
> +                       samsung,pin-pud = <3>;
> +                       samsung,pin-drv = <0>;
> +               };
>         };
>
>         pinctrl at 14010000 {
> @@ -249,6 +256,33 @@
>                 status = "okay";
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
> +               samsung,link-rate = <0x06>;
> +               samsung,lane-count = <2>;
> +               samsung,hpd-gpio = <&gpx2 6 0>;
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
