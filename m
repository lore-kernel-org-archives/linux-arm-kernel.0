From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 9 Jul 2016 11:53:06 +0800
Subject: [PATCH 05/15] ARM: dts: sun5i: reference-design-tablet: Remove
 mention of q8
In-Reply-To: <1467993956-19535-6-git-send-email-hdegoede@redhat.com>
References: <1467993956-19535-1-git-send-email-hdegoede@redhat.com>
 <1467993956-19535-6-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67S9s5PifX4JOjp6DK57Q3aVRrKMdf7y75vna2rdrASFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 9, 2016 at 12:05 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Remove all mention of q8 from sun5i-reference-design-tablet.dtsi.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
> index e78452c..20cc940 100644
> --- a/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
> +++ b/arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi
> @@ -98,7 +98,7 @@
>
>  &mmc0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_q8>;
> +       pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
>         vmmc-supply = <&reg_vcc3v0>;
>         bus-width = <4>;
>         cd-gpios = <&pio 6 0 GPIO_ACTIVE_HIGH>; /* PG0 */
> @@ -118,7 +118,7 @@
>                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>         };
>
> -       mmc0_cd_pin_q8: mmc0_cd_pin at 0 {
> +       mmc0_cd_pin: mmc0_cd_pin at 0 {

We could name this mmc0_cd_pin_reference_design and put it in
sun5i-a13.dtsi. We already do this for A10/A20.

This works equally well though.

Acked-by: Chen-Yu Tsai <wens@csie.org>

>                 allwinner,pins = "PG0";
>                 allwinner,function = "gpio_in";
>                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> --
> 2.7.4
>
