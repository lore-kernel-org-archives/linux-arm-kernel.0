From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:36:33 +0800
Subject: [PATCH 58/77] ARM: dts: sun8i: a23/a33: Remove redundant MMC
 pinmux tuning
In-Reply-To: <d856497c2ad879816c6f944128bc62371f604f7a.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <d856497c2ad879816c6f944128bc62371f604f7a.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67H0pAODp2dixSi-cjhMiBcc_YwoKkCxf4msZ4522A88A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Some boards override the MMC pin muxing settings in order to enable the
> pull-ups and change the drive strength to a value higher than the default.
>
> While this was needed in the earlier days, this is now the default setting
> for those pins, and therefore we don't need those board-specific settings
> anymore.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  arch/arm/boot/dts/sun8i-a23-polaroid-mid2407pxe03.dts | 4 ----
>  arch/arm/boot/dts/sun8i-a23-polaroid-mid2809pxe04.dts | 4 ----
>  arch/arm/boot/dts/sun8i-a33-inet-d978-rev2.dts        | 4 ----
>  arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts        | 7 -------
>  arch/arm/boot/dts/sun8i-q8-common.dtsi                | 4 ----
>  arch/arm/boot/dts/sun8i-r16-parrot.dts                | 5 -----
>  6 files changed, 28 deletions(-)
>

[...]

> diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> index b343153948f4..7e006d0fbf27 100644
> --- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> +++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
> @@ -151,13 +151,6 @@
>         status = "okay";
>  };
>
> -&mmc2_8bit_pins {
> -       /* Increase drive strength for DDR modes */
> -       drive-strength = <40>;

This is not the default. Maybe we should make it the default?


> -       /* eMMC is missing pull-ups */
> -       bias-pull-up;
> -};
> -
>  &ohci0 {
>         status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/sun8i-q8-common.dtsi b/arch/arm/boot/dts/sun8i-q8-common.dtsi
> index c676940a96da..0b3db925254b 100644
> --- a/arch/arm/boot/dts/sun8i-q8-common.dtsi
> +++ b/arch/arm/boot/dts/sun8i-q8-common.dtsi
> @@ -82,10 +82,6 @@
>         };
>  };
>
> -&mmc1_pins_a {
> -       bias-pull-up;
> -};
> -
>  &r_pio {
>         wifi_pwrseq_pin_q8: wifi_pwrseq_pin at 0 {
>                 pins = "PL6", "PL7", "PL11";
> diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
> index 472c03b7aeab..5d93a2711dc3 100644
> --- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
> +++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
> @@ -156,11 +156,6 @@
>         status = "okay";
>  };
>
> -&mmc2_8bit_pins {
> -       drive-strength = <40>;

Same here. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> -       bias-pull-up;
> -};
> -
>  &ohci0 {
>         status = "okay";
>  };
> --
> git-series 0.9.1
