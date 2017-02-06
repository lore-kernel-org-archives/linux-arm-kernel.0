From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Feb 2017 15:15:15 +0800
Subject: [PATCH 3/9] ARM: sunxi: Rename pwm0_pins to match our usual
 pattern
In-Reply-To: <d78adf8ff6ceedadeda235b3abda73f8bc87d377.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <d78adf8ff6ceedadeda235b3abda73f8bc87d377.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64tnnG-CTF1C5yqj=VTmB-J_E9dH6Sit8fvWJD-ddw13A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The pwm0_pins group name is suggesting that this is the only option usable
> for the PWM0 on the SoCs it's declared on. However, this is not the case
> and defining a second pwm0 group would be quite weird given the name of the
> first group.

Can you elaborate on the second pwm0 option? I'm not seeing it in my datasheets.

ChenYu

>
> Rename it so that it matches our usual pattern.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts |  2 +-
>  arch/arm/boot/dts/sun5i.dtsi                           | 10 +++++-----
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi                   |  2 +-
>  arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi   |  2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
> index 42435454acef..1bc87523b37c 100644
> --- a/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
> +++ b/arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
> @@ -157,7 +157,7 @@
>
>  &pwm {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pwm0_pins>;
> +       pinctrl-0 = <&pwm0_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> index a9574a6cd95c..fce3ec693531 100644
> --- a/arch/arm/boot/dts/sun5i.dtsi
> +++ b/arch/arm/boot/dts/sun5i.dtsi
> @@ -321,6 +321,11 @@
>                                 bias-pull-up;
>                         };
>
> +                       pwm0_pins_a: pwm0 at 0 {
> +                               pins = "PB2";
> +                               function = "pwm0";
> +                       };
> +
>                         spi2_pins_a: spi2 at 0 {
>                                 pins = "PE1", "PE2", "PE3";
>                                 function = "spi2";
> @@ -340,11 +345,6 @@
>                                 pins = "PG11", "PG12";
>                                 function = "uart3";
>                         };
> -
> -                       pwm0_pins: pwm0 {
> -                               pins = "PB2";
> -                               function = "pwm";
> -                       };
>                 };
>
>                 timer at 01c20c00 {
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index 35008b78d899..b558d318a72e 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -316,7 +316,7 @@
>                                 bias-pull-up;
>                         };
>
> -                       pwm0_pins: pwm0 {
> +                       pwm0_pins_a: pwm0 {
>                                 pins = "PH0";
>                                 function = "pwm0";
>                         };
> diff --git a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> index b8241462fcea..5cd891942fe3 100644
> --- a/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> +++ b/arch/arm/boot/dts/sunxi-reference-design-tablet.dtsi
> @@ -78,6 +78,6 @@
>
>  &pwm {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&pwm0_pins>;
> +       pinctrl-0 = <&pwm0_pins_a>;
>         status = "okay";
>  };
> --
> git-series 0.8.11
