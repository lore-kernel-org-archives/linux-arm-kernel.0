From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 16 Feb 2018 10:36:23 +0100
Subject: [PATCH 05/15] ARM64: dts: Add R-Car Salvator-x M3-N support
In-Reply-To: <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-6-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdXQQqRTir-3wgorh_QX060K_CyQNStA46Ph+hnrikqCaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add initial support for R-Car M3-N Salvator-x and r8a77965 SoC in
> device tree with cpg-mssr, reset and clock nodes.
>
> Add place-holder device nodes for all nodes referred by
> "salvator-common.dtsi"
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi

> +               gic: interrupt-controller at f1010000 {
> +                       compatible = "arm,gic-400";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0x0 0xf1010000 0 0x1000>,
> +                             <0x0 0xf1020000 0 0x20000>,
> +                             <0x0 0xf1040000 0 0x20000>,
> +                             <0x0 0xf1060000 0 0x20000>;
> +                       interrupts = <GIC_PPI 9
> +                                       (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;

Given you have 2 CPU cores, it should say GIC_CPU_MASK_SIMPLE(2).

> +                       clocks = <&cpg CPG_MOD 408>;
> +                       clock-names = "clk";
> +                       power-domains = <&sysc R8A77965_PD_ALWAYS_ON>;
> +                       resets = <&cpg 408>;
> +               };
> +
> +               timer {
> +                       compatible = "arm,armv8-timer";
> +                       interrupts = <GIC_PPI 13
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 14
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 11
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 10
> +                                       (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW)>;

This one is correct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
