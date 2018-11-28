From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 11:28:57 +0800
Subject: [PATCH 10/77] ARM: dts: sun5i: Remove all useless pinctrl nodes
In-Reply-To: <820ad10fea1f06f9be94497f82df3cd6cad070b1.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <820ad10fea1f06f9be94497f82df3cd6cad070b1.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64rQ25Q1Q2JLXUw8wjya-Rvf7-jW1vzGW0zSMQiZhRxbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> The gpio pinctrl nodes are redundant and as such useless most of the times.
> Since they will also generate warnings in DTC, we can simply remove most of
> them.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts         |  6 +---
>  arch/arm/boot/dts/sun5i-a10s-mk802.dts               | 13 +------
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts     |  6 +---
>  arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts        |  6 +---
>  arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts             | 14 +-------
>  arch/arm/boot/dts/sun5i-a13-hsg-h702.dts             |  7 +---
>  arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts      | 12 +------
>  arch/arm/boot/dts/sun5i-a13-olinuxino.dts            |  6 +---
>  arch/arm/boot/dts/sun5i-a13-utoo-p66.dts             |  8 +----
>  arch/arm/boot/dts/sun5i-gr8-chip-pro.dts             | 16 +--------
>  arch/arm/boot/dts/sun5i-gr8-evb.dts                  | 27 +-------------
>  arch/arm/boot/dts/sun5i-r8-chip.dts                  | 19 +---------
>  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi | 21 +----------
>  13 files changed, 2 insertions(+), 159 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> index 8d4fb9331212..d5bca68ca6ca 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts
> @@ -72,7 +72,6 @@
>         reg_vmmc1: vmmc1 {
>                 compatible = "regulator-fixed";
>                 pinctrl-names = "default";

You can also drop pinctrl-names? Or is it actually desired?
IIRC the pinctrl core complains if it can't find a default setting.

> -               pinctrl-0 = <&mmc1_vcc_en_pin_t004>;
>                 regulator-name = "vmmc1";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
> @@ -139,11 +138,6 @@
>                 bias-pull-up;
>         };
>
> -       mmc1_vcc_en_pin_t004: mmc1_vcc_en_pin at 0 {
> -               pins = "PB18";
> -               function = "gpio_out";
> -       };
> -
>         led_pins_t004: led_pins at 0 {
>                 pins = "PB2";
>                 function = "gpio_out";
> diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
> index dd7fd5c3d76f..b17c036293d6 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
> @@ -59,8 +59,6 @@
>
>         leds {
>                 compatible = "gpio-leds";
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&led_pins_mk802>;

You did remove it here.

The rest looks ok, so

Acked-by: Chen-Yu Tsai <wens@csie.org>

One thing worth noting is that the pinctrl overrides for common vbus regulators
haven't had any effect for a while since I removed the default pinctrl settings
for the GPIO pins.
