From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 19 Oct 2016 10:34:41 +0200
Subject: [PATCH v3 06/11] ARM: dts: r8a7743: add [H]SCIF{A|B} support
In-Reply-To: <14213508.lp3q5ZvmbF@wasted.cogentembedded.com>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <14213508.lp3q5ZvmbF@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUaCKh-WFth9q3-1fM+4_Wpi0T2kSEkexo8aZNQoe3pzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 5, 2016 at 11:41 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe [H]SCIF[AB] ports in the R8A7743 device tree.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

With the modifications indicated below:

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
> @@ -162,6 +162,267 @@
>                         #dma-cells = <1>;
>                         dma-channels = <15>;
>                 };
> +
> +               scifa0: serial at e6c40000 {
> +                       compatible = "renesas,scifa-r8a7743",
> +                                    "renesas,rzg-scifa", "renesas,scifa";

Please use "renesas,rcar-gen2-scifa" instead of "renesas,rzg-scifa".

> +               scifb0: serial at e6c20000 {
> +                       compatible = "renesas,scifb-r8a7743",
> +                                    "renesas,rzg-scifb", "renesas,scifb";

"renesas,rcar-gen2-scifb"

> +               scif0: serial at e6e60000 {
> +                       compatible = "renesas,scif-r8a7743", "renesas,rzg-scif",

"renesas,rcar-gen2-scif"

> +               hscif0: serial at e62c0000 {
> +                       compatible = "renesas,hscif-r8a7743",
> +                                    "renesas,rzg-hscif", "renesas,hscif";

"renesas,rcar-gen2-hscif"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
