From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 15:13:47 +0100
Subject: [PATCH 10/15] ARM64: dts: r8a77965: Add SCIF device nodes
In-Reply-To: <1518515162-23663-11-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-11-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdUe1QJq8wFCbc4LoYKzn9roUoAj2iNGfEYfZM=RHtPgpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add SCIF[0-5] device nodes for M3-N (r8a77965) SoC.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi

>                 scif3: serial at e6c50000 {
> -                       /* placeholder */
> +                       compatible = "renesas,scif-r8a7796",

renesas,scif-r8a77965

> +                                    "renesas,rcar-gen3-scif", "renesas,scif";
> +                       reg = <0 0xe6c50000 0 64>;
> +                       interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 204>,
> +                                <&cpg CPG_CORE R8A77965_CLK_S3D1>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac0 0x57>, <&dmac0 0x56>;
> +                       dma-names = "tx", "rx";
> +                       power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +                       resets = <&cpg 204>;
> +                       status = "disabled";
>                 };
>
>                 scif4: serial at e6c40000 {
> -                       /* placeholder */
> +                       compatible = "renesas,scif-r8a7796",

renesas,scif-r8a77965

> +                                    "renesas,rcar-gen3-scif", "renesas,scif";
> +                       reg = <0 0xe6c40000 0 64>;
> +                       interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 203>,
> +                                <&cpg CPG_CORE R8A77965_CLK_S3D1>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac0 0x59>, <&dmac0 0x58>;
> +                       dma-names = "tx", "rx";
> +                       power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +                       resets = <&cpg 203>;
> +                       status = "disabled";
>                 };
>
>                 scif5: serial at e6f30000 {
> -                       /* placeholder */
> +                       compatible = "renesas,scif-r8a7796",

renesas,scif-r8a77965

> +                                    "renesas,rcar-gen3-scif", "renesas,scif";
> +                       reg = <0 0xe6f30000 0 64>;
> +                       interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 202>,
> +                                <&cpg CPG_CORE R8A77965_CLK_S3D1>,
> +                                <&scif_clk>;
> +                       clock-names = "fck", "brg_int", "scif_clk";
> +                       dmas = <&dmac1 0x5b>, <&dmac1 0x5a>,
> +                              <&dmac2 0x5b>, <&dmac2 0x5a>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +                       resets = <&cpg 202>;
> +                       status = "disabled";

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
