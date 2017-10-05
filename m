From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:49:47 +0800
Subject: [PATCH 12/20] ARM: dts: sun4i: Remove underscores from nodes names
In-Reply-To: <2b7de818cec2fcbc75335a2c6eb3816c6718cb26.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <2b7de818cec2fcbc75335a2c6eb3816c6718cb26.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v6472+oknoc0uXf+Z_Onm-AEFiN7HenjdetK-s2QJ3TZ3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some GPIO pinctrl nodes cannot be easily removed, because they would also
> change the pin configuration, for example to add a pull resistor or change
> the current delivered by the pin.
>
> Those nodes still have underscores and unit-addresses in their node names
> in our DTs, so adjust their name to remove the warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

[...]

> diff --git a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> index 46e485ff925b..5081303f79e7 100644
> --- a/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts
> @@ -101,7 +101,7 @@
>  &i2c2 {
>         status = "okay";
>
> -       pixcir_ts at 5c {
> +       touchscreen at 5c {

You also fixed up a name here. Please mention it.

>                 compatible = "pixcir,pixcir_tangoc";
>                 reg = <0x5c>;
>                 interrupt-parent = <&pio>;

[...]

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
