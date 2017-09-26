From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 15:46:13 +0800
Subject: [PATCH v3 13/14] arm64: allwinner: a64: fix pin name
In-Reply-To: <20170926072234.27481-14-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
 <20170926072234.27481-14-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v67R1k_RxK4n+eGNyzqD44efSwTKZ028=5AiiBbVqBeEjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 3:22 PM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> All pinmux nodes should have the suffix "_pins" or "_pin".
>
> In the case where there are multiple choices, the node name should convey
> what or which pingroup the choice is.
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts     | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts       | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts        | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts     | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts           | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi                 | 6 +++---
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> index 45bdbfb96126..36a56e3ab92f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
> @@ -248,7 +248,7 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +       pinctrl-0 = <&uart0_pb_pins>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> index 2beef9e6cb88..15019edb7dd6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
> @@ -198,7 +198,7 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +       pinctrl-0 = <&uart0_pb_pins>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> index 338e786155b1..ec62c86cc236 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
> @@ -194,6 +194,6 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +       pinctrl-0 = <&uart0_pb_pins>;
>         status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index 5f8ff4017d45..1c8b9d2721f0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -85,7 +85,7 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +       pinctrl-0 = <&uart0_pb_pins>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 806442d3e846..69743ff171d0 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -232,7 +232,7 @@
>  /* On Exp and Euler connectors */
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +       pinctrl-0 = <&uart0_pb_pins>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 0eb2acedf8c3..e41eb71eb438 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -135,7 +135,7 @@
>
>  &uart0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&uart0_pins_a>;
> +       pinctrl-0 = <&uart0_pb_pins>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index b02a8476b0c8..2d2937b7dc68 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -347,7 +347,7 @@
>                                 function = "spi1";
>                         };
>
> -                       uart0_pins_a: uart0 {
> +                       uart0_pb_pins: uart0 {

You are again confusing node names with node labels.
And it doesn't match what your commit message says.

The node name is what never changes even when the device
tree is compiled into a binary blob. The label gets compiled
out, and any references to it are converted to an integer
index, much like how a goto label in C gets compiled.

Of the two, the node name is what I asked to be changed.
Please take a look at arch/arm/boot/dts/sun8i-a83t.dtsi
for a proper example of what I am asking for. Note that
node names should use hyphens, not underscores, while
labels should use underscores. For the pinmux nodes
the name and label would likely be the same except for
this exception. So your uart0 label changes are good.
Please keep them.

>                                 pins = "PB8", "PB9";
>                                 function = "uart0";
>                         };
> @@ -571,7 +571,7 @@
>                         interrupt-controller;
>                         #interrupt-cells = <3>;
>
> -                       r_rsb_pins: rsb {
> +                       rsb_pins: rsb {

I'm not sure why you changed this label. It doesn't make sense.

>                                 pins = "PL0", "PL1";
>                                 function = "s_rsb";
>                         };
> @@ -585,7 +585,7 @@
>                         clock-frequency = <3000000>;
>                         resets = <&r_ccu 2>;
>                         pinctrl-names = "default";
> -                       pinctrl-0 = <&r_rsb_pins>;
> +                       pinctrl-0 = <&rsb_pins>;
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.13.5
>
