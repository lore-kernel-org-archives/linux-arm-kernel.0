From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Aug 2015 09:22:45 +0200
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7794: add GPIO DT support
In-Reply-To: <2762710.QvQ3jKvG4A@wasted.cogentembedded.com>
References: <6388101.Drn6rL87rl@wasted.cogentembedded.com>
 <2762710.QvQ3jKvG4A@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUuHtmZfd7vei0qdP9n_gvd6C1xBbDWkkSdPRTrTPxiOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Mon, Aug 3, 2015 at 11:39 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe GPIO[0-6] controllers in the R8A7794 device tree.
>
> Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

As CPG/MSTP Clock Domain support is in, I have to withdraw my Acked-by.

> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> @@ -50,6 +50,90 @@
>                 interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
>         };
>
> +       gpio0: gpio at e6050000 {
> +               compatible = "renesas,gpio-r8a7794", "renesas,gpio-rcar";
> +               reg = <0 0xe6050000 0 0x50>;
> +               interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
> +               #gpio-cells = <2>;
> +               gpio-controller;
> +               gpio-ranges = <&pfc 0 0 32>;
> +               #interrupt-cells = <2>;
> +               interrupt-controller;
> +               clocks = <&mstp9_clks R8A7794_CLK_GPIO0>;

Missing "power-domains = <&cpg_clocks>;"

> +       };

Same comment for the other gpio device nodes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
