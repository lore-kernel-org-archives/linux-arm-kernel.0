From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 14 Mar 2016 10:23:01 +0100
Subject: [PATCH 1/2] ARM: dts: r8a7794: add CAN clocks to device tree
In-Reply-To: <1457922543-20975-2-git-send-email-horms+renesas@verge.net.au>
References: <1457922543-20975-1-git-send-email-horms+renesas@verge.net.au>
 <1457922543-20975-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUWN9UVsDFxRCH6b+i7ERP5-W5wc6oU+OjYi=VYXS6UCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Mar 14, 2016 at 3:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi
> @@ -844,6 +844,24 @@
>                         clock-output-names = "extal";
>                 };
>
> +               /* External USB clock - can be overridden by the board */
> +               usb_extal_clk: usb_extal_clk {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <48000000>;
> +                       clock-output-names = "usb_extal";

"clock-output-names" is optional these days, so please drop it.
The clock will be named after the node name, so please rename it to
"usb_extal".

> +               };
> +
> +               /* External CAN clock */
> +               can_clk: can_clk {

can_clk: can {

> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       /* This value must be overridden by the board. */
> +                       clock-frequency = <0>;
> +                       clock-output-names = "can_clk";

Likewise.

> +                       status = "disabled";
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
