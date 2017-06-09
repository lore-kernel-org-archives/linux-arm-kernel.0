From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 10 Jun 2017 00:37:09 +0200
Subject: [PATCH v4 6/7] ARM: dts: meson8: switch to new bindings for UART
 nodes
In-Reply-To: <1497001756-942-7-git-send-email-narmstrong@baylibre.com>
References: <1497001756-942-1-git-send-email-narmstrong@baylibre.com>
 <1497001756-942-7-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCD6_nGdqBSOJwyj0XQe8H05nw-r52pctY7ADJu0EqMb2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Fri, Jun 9, 2017 at 11:49 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> Switch to the stable UART bindings by adding a XTAL node and using the
> proper compatible strings.
unfortunately this won't apply now that Kevin has merged my "ARM: dts:
meson8: add and use the real clock controller"
on the other hand this will make the patch easier as you can now do
the same changes as in meson8b.dtsi

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm/boot/dts/meson8.dtsi | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
> index 6993077..a2ea112 100644
> --- a/arch/arm/boot/dts/meson8.dtsi
> +++ b/arch/arm/boot/dts/meson8.dtsi
> @@ -83,6 +83,13 @@
>                 };
>         };
>
> +       xtal: xtal-clk {
> +               compatible = "fixed-clock";
> +               clock-frequency = <24000000>;
> +               clock-output-names = "xtal";
> +               #clock-cells = <0>;
> +       };
> +
>         clk81: clk at 0 {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> @@ -199,17 +206,25 @@
>  };
>
>  &uart_AO {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart", "amlogic,meson-ao-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
>
>  &uart_A {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
>
>  &uart_B {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
>
>  &uart_C {
> -       clocks = <&clk81>;
> +       compatible = "amlogic,meson8-uart";
> +       clocks = <&xtal>, <&clk81>, <&clk81>;
> +       clock-names = "xtal", "pclk", "baud";
>  };
> --
> 1.9.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
