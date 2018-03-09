From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Mar 2018 13:36:19 +0100
Subject: [PATCH 1/3] arm64: dts: renesas: r8a77980: add PFC support
In-Reply-To: <e1130d4e-7c70-fe3d-1a09-349e95ad1b33@cogentembedded.com>
References: <88e52531-e538-8685-110a-1a2e79a3fe49@cogentembedded.com>
 <e1130d4e-7c70-fe3d-1a09-349e95ad1b33@cogentembedded.com>
Message-ID: <CAMuHMdW_Ub-iVGbgmHzp6QqUCUXL0X8bYaa=yZP=1GQkLWDr=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 1:06 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A77980 part of the PFC device node.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -71,6 +71,11 @@
>                 #size-cells = <2>;
>                 ranges;
>
> +               pfc: pin-controller at e6060000 {
> +                       compatible = "renesas,pfc-r8a77980";
> +                       reg = <0 0xe6060000 0 0x50c>;

0x50c is an odd number, given the last register is at offset 0x500, just like
on V3M ;-)

> +               };
> +

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
