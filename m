From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:41:46 +0800
Subject: [PATCH 65/77] ARM: dts: sunxi: reference: Move the muxing back to
 the common DTSI
In-Reply-To: <0d7bc6062323688d22b7873e2a1fa354ab42a0af.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <0d7bc6062323688d22b7873e2a1fa354ab42a0af.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v656FWyqqzmC9BJD0Am+ic1BEH+ntqxiW45sTsTQ28eixQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Now that all the SoCs using the tablet reference design DTSI are using the
> same pinctrl naming scheme, we can move back the pinctrl phandles to the
> main DTSI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun5i-reference-design-tablet.dtsi |  8 --------
>  arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi |  9 ---------
>  arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi |  6 +++---
>  3 files changed, 3 insertions(+), 20 deletions(-)

[...]

> diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> index 00dc6623f30f..117198c52e1f 100644
> --- a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> +++ b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> @@ -46,13 +46,13 @@
>
>  &i2c0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&i2c0_pins_a>;
> +       pinctrl-0 = <&i2c0_pins>;
>         status = "okay";
>  };
>
>  &i2c1 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&i2c1_pins_a>;
> +       pinctrl-0 = <&i2c1_pins>;

I assume a build break was avoided because we were overriding these?

Acked-by: Chen-Yu Tsai <wens@csie.org>

>         status = "okay";
>  };
>
> @@ -77,6 +77,6 @@
>
>  &pwm {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pwm0_pins>;
> +       pinctrl-0 = <&pwm0_pin>;
>         status = "okay";
>  };
> --
> git-series 0.9.1
