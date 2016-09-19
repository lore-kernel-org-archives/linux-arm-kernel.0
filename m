From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 10:32:52 +0200
Subject: [PATCH RFC 7/8] ARM: dts: r8a7743: add [H]SCIF support
In-Reply-To: <2338956.oSVFAsJyhK@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <2338956.oSVFAsJyhK@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXa0WiEPfR9mtjTWoox_n5GucPsHB5Gk6xcoW-_TWVUuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Sep 16, 2016 at 3:37 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Describe [H]SCIFs in the R8A7743 device tree.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- renesas.orig/arch/arm/boot/dts/r8a7743.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
> @@ -154,6 +154,268 @@
>                         dma-channels = <15>;
>                 };
>
> +               scifa0: serial at e6c40000 {
> +                       compatible = "renesas,scifa-r8a7743",

To be documented...

> +                                    "renesas,rcar-gen2-scifa", "renesas,scifa";
> +                       reg = <0 0xe6c40000 0 64>;
> +                       interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp2_clks R8A7743_CLK_SCIFA0>;
> +                       clock-names = "fck";
> +                       dmas = <&dmac0 0x21>, <&dmac0 0x22>,
> +                              <&dmac1 0x21>, <&dmac1 0x22>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +                       status = "disabled";
> +               };

[...]

> +               scifb0: serial at e6c20000 {
> +                       compatible = "renesas,scifb-r8a7743",

To be documented...

> +                                    "renesas,rcar-gen2-scifb", "renesas,scifb";
> +                       reg = <0 0xe6c20000 0 64>;

This does not cover the whole register block (aha, also on existing Gen2).
"reg = <0 0xe6c20000 0 256>;"?

> +                       interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp2_clks R8A7743_CLK_SCIFB0>;
> +                       clock-names = "fck";
> +                       dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
> +                      <&dmac1 0x3d>, <&dmac1 0x3e>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +                       status = "disabled";
> +               };

[...]

> +               scif0: serial at e6e60000 {
> +                       compatible = "renesas,scif-r8a7743",

To be documented...

> +                                    "renesas,rcar-gen2-scif", "renesas,scif";
> +                       reg = <0 0xe6e60000 0 64>;
> +                       interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp7_clks R8A7743_CLK_SCIF0>, <&zs_clk>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac0 0x29>, <&dmac0 0x2a>,
> +                              <&dmac1 0x29>, <&dmac1 0x2a>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +                       status = "disabled";
> +               };
> +
> +               scif1: serial at e6e68000 {
> +                       compatible = "renesas,scif-r8a7743",
> +                                    "renesas,rcar-gen2-scif", "renesas,scif";
> +                       reg = <0 0xe6e68000 0 64>;
> +                       interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp7_clks R8A7743_CLK_SCIF1>, <&zs_clk>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac0 0x2d>, <&dmac0 0x2e>,
> +                              <&dmac1 0x2d>, <&dmac1 0x2e>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +                       status = "disabled";
> +               };

[...]

> +               hscif0: serial at e62c0000 {
> +                       compatible = "renesas,hscif-r8a7743",

To be documented...

> +                                    "renesas,rcar-gen2-hscif", "renesas,hscif";
> +                       reg = <0 0xe62c0000 0 96>;
> +                       interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&mstp7_clks R8A7743_CLK_HSCIF0>, <&zs_clk>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac0 0x39>, <&dmac0 0x3a>,
> +                              <&dmac1 0x39>, <&dmac1 0x3a>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A7743_PD_ALWAYS_ON>;
> +                       status = "disabled";
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
