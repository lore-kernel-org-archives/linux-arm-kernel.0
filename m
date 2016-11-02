From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Nov 2016 11:12:11 +0100
Subject: [PATCH 06/11] ARM: dts: r8a7745: add [H]SCIF{A|B} support
In-Reply-To: <2366203.iKt2DUneo7@wasted.cogentembedded.com>
References: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
 <2366203.iKt2DUneo7@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUZULyFwAoteXf+g=RWP=gBs0jDMVGpNUT_A=kPdDwSYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 12:19 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe [H]SCIF{|A|B} ports in the R8A7745 device tree.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

After you've fixed the family-specific compatible values:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm/boot/dts/r8a7745.dtsi |  261 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 261 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7745.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7745.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7745.dtsi
> @@ -157,6 +157,267 @@
>                         #dma-cells = <1>;
>                         dma-channels = <15>;
>                 };
> +
> +               scifa0: serial at e6c40000 {
> +                       compatible = "renesas,scifa-r8a7745",
> +                                    "renesas,rzg-scifa", "renesas,scifa";

s/renesas,rzg-/renesas,rcar-gen2-/g

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
