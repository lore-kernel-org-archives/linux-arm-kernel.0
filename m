From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 5 Jul 2016 09:29:39 +0200
Subject: [PATCH v2 3/3] ARM: dts: blanche: add Ethernet pins
In-Reply-To: <3279336.lifIduxqUW@wasted.cogentembedded.com>
References: <2793535.9X0Tq7I1Mq@wasted.cogentembedded.com>
 <3279336.lifIduxqUW@wasted.cogentembedded.com>
Message-ID: <CAMuHMdU3yDe7fFtVArMGqMc6oyHXtFxeR8t6cqPranSg7R+12g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Jul 4, 2016 at 10:55 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the (previously omitted) pin data for the SMSC LAN89218 Ethernet chip
> to the Blanche board's device tree: the chip's IRQ output is connected to
> the SoC's IRQ0 pin and its nCS input is connected to the SoC's EX_CS0# pin.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/boot/dts/r8a7792-blanche.dts |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7792-blanche.dts
> +++ renesas/arch/arm/boot/dts/r8a7792-blanche.dts
> @@ -50,6 +50,9 @@
>                 reg-io-width = <4>;
>                 vddvario-supply = <&d3_3v>;
>                 vdd33a-supply = <&d3_3v>;
> +
> +               pinctrl-0 = <&lan89218_pins>;
> +               pinctrl-names = "default";
>         };
>  };
>
> @@ -67,6 +70,18 @@
>                 groups = "scif3_data";
>                 function = "scif3";
>         };
> +
> +       lan89218_pins: lan89218 {
> +               intc {
> +                       groups = "intc_irq0";
> +                       function = "intc";
> +               };
> +               lbsc {
> +                       groups = "lbsc_ex_cs0";
> +                       function = "lbsc";

Don't you need pinctrl for the other LBSC pins, like the address and data lines
(Ax and Dy)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
