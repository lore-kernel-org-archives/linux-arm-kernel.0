From: codekipper@gmail.com (Code Kipper)
Date: Sat, 2 May 2015 13:42:20 +0200
Subject: [linux-sunxi] ARM: sunxi: dts: split IR pins for A10 and A20
In-Reply-To: <1430566580-14295-1-git-send-email-codekipper@gmail.com>
References: <1430566580-14295-1-git-send-email-codekipper@gmail.com>
Message-ID: <CAEKpxBmp456qWrPRM7H-FVY5V3whZZLx1teNv7KLSbxsjhLVmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of the patch after Maxime's comments. Was trying to add
versioning comments to below the commit message but for some reason
adding --subject to the send-email command seemed to cancel out the
--dry-run. So it's out in the wild.
CK

On 2 May 2015 at 13:36,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Currently none of the target boards nor the driver supports
> IR TX. However this pin is used in a few instances as a GPIO.
> Split the pin ctrl descriptions so that only the IR RX is
> configured to be used.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-a1000.dts         |  2 +-
>  arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts    |  2 +-
>  arch/arm/boot/dts/sun4i-a10-cubieboard.dts    |  2 +-
>  arch/arm/boot/dts/sun4i-a10-hackberry.dts     |  2 +-
>  arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts    |  2 +-
>  arch/arm/boot/dts/sun4i-a10-mini-xplus.dts    |  4 ++--
>  arch/arm/boot/dts/sun4i-a10.dtsi              | 22 ++++++++++++++++++----
>  arch/arm/boot/dts/sun7i-a20-bananapi.dts      |  2 +-
>  arch/arm/boot/dts/sun7i-a20-bananapro.dts     |  2 +-
>  arch/arm/boot/dts/sun7i-a20-cubieboard2.dts   |  2 +-
>  arch/arm/boot/dts/sun7i-a20-cubietruck.dts    |  2 +-
>  arch/arm/boot/dts/sun7i-a20-hummingbird.dts   |  2 +-
>  arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts     |  2 +-
>  arch/arm/boot/dts/sun7i-a20-m3.dts            |  2 +-
>  arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts |  2 +-
>  arch/arm/boot/dts/sun7i-a20-orangepi.dts      |  2 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts |  2 +-
>  arch/arm/boot/dts/sun7i-a20-pcduino3.dts      |  2 +-
>  arch/arm/boot/dts/sun7i-a20.dtsi              | 22 ++++++++++++++++++----
>  19 files changed, 54 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-a1000.dts b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> index f032814..57970d0 100644
> --- a/arch/arm/boot/dts/sun4i-a10-a1000.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-a1000.dts
> @@ -130,7 +130,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> index 1a3c7dd..62e4b36 100644
> --- a/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts
> @@ -96,7 +96,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index 0ba67d7..db204b1 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -126,7 +126,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-hackberry.dts b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> index f443788..835eb30 100644
> --- a/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-hackberry.dts
> @@ -93,7 +93,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> index 1b0452f..4281782 100644
> --- a/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts
> @@ -126,7 +126,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> index 0f24914..132ace5 100644
> --- a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
> @@ -92,11 +92,11 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> -&ir0_pins_a {
> +&ir0_rx_pins_a {
>         /* The ir receiver is not always populated */
>         allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>  };
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 1d7fd68..7529857 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -797,15 +797,29 @@
>                                 allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
>                         };
>
> -                       ir0_pins_a: ir0 at 0 {
> -                               allwinner,pins = "PB3","PB4";
> +                       ir0_rx_pins_a: ir0 at 0 {
> +                               allwinner,pins = "PB4";
>                                 allwinner,function = "ir0";
>                                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>                         };
>
> -                       ir1_pins_a: ir1 at 0 {
> -                               allwinner,pins = "PB22","PB23";
> +                       ir0_tx_pins_a: ir0 at 1 {
> +                               allwinner,pins = "PB3";
> +                               allwinner,function = "ir0";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       ir1_rx_pins_a: ir1 at 0 {
> +                               allwinner,pins = "PB23";
> +                               allwinner,function = "ir1";
> +                               allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                               allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       ir1_tx_pins_a: ir1 at 1 {
> +                               allwinner,pins = "PB22";
>                                 allwinner,function = "ir1";
>                                 allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi.dts b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> index b952ac4..ecc2a4d 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapi.dts
> @@ -142,7 +142,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> index 9d9027f..d408bbc 100644
> --- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
> @@ -154,7 +154,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> index 3c817ac..930ea80d 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
> @@ -133,7 +133,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> index 613a19e..8a83c99 100644
> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
> @@ -160,7 +160,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> index d3f15c2..9a4d783 100644
> --- a/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-hummingbird.dts
> @@ -160,7 +160,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> index 3f99b3f..d9782c4 100644
> --- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
> @@ -157,7 +157,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-m3.dts b/arch/arm/boot/dts/sun7i-a20-m3.dts
> index f2fb26e..39b4a80 100644
> --- a/arch/arm/boot/dts/sun7i-a20-m3.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-m3.dts
> @@ -117,7 +117,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
> index 0556938..bf6dd25 100644
> --- a/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts
> @@ -137,7 +137,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-orangepi.dts b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
> index 7e6405c..b282dda 100644
> --- a/arch/arm/boot/dts/sun7i-a20-orangepi.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-orangepi.dts
> @@ -132,7 +132,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> index 810c5f7..f14cd60 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts
> @@ -125,7 +125,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> index cd05267..2578959 100644
> --- a/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-pcduino3.dts
> @@ -154,7 +154,7 @@
>
>  &ir0 {
>         pinctrl-names = "default";
> -       pinctrl-0 = <&ir0_pins_a>;
> +       pinctrl-0 = <&ir0_rx_pins_a>;
>         status = "okay";
>  };
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 4163ade..89d7206 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -1000,15 +1000,29 @@
>                                 allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>                         };
>
> -                       ir0_pins_a: ir0 at 0 {
> -                                   allwinner,pins = "PB3","PB4";
> +                       ir0_rx_pins_a: ir0 at 0 {
> +                                   allwinner,pins = "PB4";
>                                     allwinner,function = "ir0";
>                                     allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                                     allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
>                         };
>
> -                       ir1_pins_a: ir1 at 0 {
> -                                   allwinner,pins = "PB22","PB23";
> +                       ir0_tx_pins_a: ir0 at 1 {
> +                                   allwinner,pins = "PB3";
> +                                   allwinner,function = "ir0";
> +                                   allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                                   allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       ir1_rx_pins_a: ir1 at 0 {
> +                                   allwinner,pins = "PB23";
> +                                   allwinner,function = "ir1";
> +                                   allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +                                   allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> +                       };
> +
> +                       ir1_tx_pins_a: ir1 at 1 {
> +                                   allwinner,pins = "PB22";
>                                     allwinner,function = "ir1";
>                                     allwinner,drive = <SUN4I_PINCTRL_10_MA>;
>                                     allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
> --
> 2.3.6
>
