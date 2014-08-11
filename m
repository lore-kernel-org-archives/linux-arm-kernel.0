From: dianders@chromium.org (Doug Anderson)
Date: Mon, 11 Aug 2014 08:57:24 -0700
Subject: [RESEND PATCH 2/2] ARM: dts: Add tps65090 FET constraints on
 Peach Pit and Pi
In-Reply-To: <1407757091-18730-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1407757091-18730-1-git-send-email-javier.martinez@collabora.co.uk>
 <1407757091-18730-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <CAD=FV=XRmNkxXoxWaEfxFADrTgBrOPVX746woxiZoKck1ajwgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Mon, Aug 11, 2014 at 4:38 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Both Exynos5420 Peach Pit and Exynos5800 Peach Pi boards
> have a tps65090 PMU that has a number of switches (FETs)
> that are just on/off devices but they do have a current
> limit and the output voltage of the switch is ramped up
> within a controlled slope.
>
> After the switch is turned on, a safety timer is started
> and before this timer times out the output voltage must
> have reached the input voltage. Otherwise the switch is
> turned off expecting an overload condition.
>
> So using the maximum output voltage slew rate and the timer
> minimum and maximum timeouts, a voltage constraints can be
> expressed as bounded limits for the timeout. That is what
> is used in the board schematics and should be in the DT too.

I don't understand this, but if you and Mark are happy with it...

...I'm also not 100% certain what the above description has to do with
this change, but I'll admit to having only skimmed some of the earlier
conversations.


> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 14 ++++++++++++++
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 14 ++++++++++++++
>  2 files changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index d8710c1..eefafe6 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -386,27 +386,41 @@
>                                         };
>                                         tps65090_fet1: fet1 {
>                                                 regulator-name = "vcd_led";
> +                                               regulator-min-microvolt = <5000000>;
> +                                               regulator-max-microvolt = <1700000>;

This is almost certainly wrong.  Your max is smaller than your min.
Perhaps you want an extra 0.

>                                         };
>                                         tps65090_fet2: fet2 {
>                                                 regulator-name = "video_mid";
> +                                               regulator-min-microvolt = <4500000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_fet3: fet3 {
>                                                 regulator-name = "wwan_r";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_fet4: fet4 {
>                                                 regulator-name = "sdcard";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_fet5: fet5 {
>                                                 regulator-name = "camout";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                         };
>                                         tps65090_fet6: fet6 {
>                                                 regulator-name = "lcd_vdd";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                         };
>                                         tps65090_fet7: fet7 {
>                                                 regulator-name = "video_mid_1a";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_ldo1: ldo1 {
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 07b29b7..5c38bc0 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -384,27 +384,41 @@
>                                         };
>                                         tps65090_fet1: fet1 {
>                                                 regulator-name = "vcd_led";
> +                                               regulator-min-microvolt = <5000000>;
> +                                               regulator-max-microvolt = <1700000>;

Here, too.

>                                         };
>                                         tps65090_fet2: fet2 {
>                                                 regulator-name = "video_mid";
> +                                               regulator-min-microvolt = <4500000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_fet3: fet3 {
>                                                 regulator-name = "wwan_r";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_fet4: fet4 {
>                                                 regulator-name = "sdcard";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_fet5: fet5 {
>                                                 regulator-name = "camout";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                         };
>                                         tps65090_fet6: fet6 {
>                                                 regulator-name = "lcd_vdd";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                         };
>                                         tps65090_fet7: fet7 {
>                                                 regulator-name = "video_mid_1a";
> +                                               regulator-min-microvolt = <3000000>;
> +                                               regulator-max-microvolt = <5500000>;
>                                                 regulator-always-on;
>                                         };
>                                         tps65090_ldo1: ldo1 {

Other than 1.7V vs. 17V, this matches what I see in the tps65090
specifications.  Technically I think that this should also be applied
to other tps65090 users in mainline since it's a property shared among
every user of tps65090.  That means exynos5250-snow and
tegra114-dalmore.  I'd be tempted to say that it belongs in source
code or in a dts fragment as well.

-Doug
