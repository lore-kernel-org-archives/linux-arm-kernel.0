From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 2 Nov 2016 11:03:07 +0100
Subject: [PATCH 04/11] ARM: dts: r8a7745: initial SoC device tree
In-Reply-To: <4144867.5S9itKOJEU@wasted.cogentembedded.com>
References: <4121805.SRTmqJtRfv@wasted.cogentembedded.com>
 <4144867.5S9itKOJEU@wasted.cogentembedded.com>
Message-ID: <CAMuHMdVcHVZmZ_b4UXgG9-3kbAOydocS2mvLLFB1FAhSMQwbow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 12:17 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The  initial R8A7745 SoC device tree including CPU0, GIC, timer, SYSC, RST,
> CPG, and the required clock descriptions.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm/boot/dts/r8a7745.dtsi |  120 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 120 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7745.dtsi
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7745.dtsi

> +               gic: interrupt-controller at f1001000 {
> +                       compatible = "arm,gic-400";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <0>;
> +                       interrupt-controller;
> +                       reg = <0 0xf1001000 0 0x1000>,
> +                             <0 0xf1002000 0 0x1000>,
> +                             <0 0xf1004000 0 0x2000>,
> +                             <0 0xf1006000 0 0x2000>;
> +                       interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(2) |
> +                                     IRQ_TYPE_LEVEL_HIGH)>;

You may want to align IRQ_TYPE_LEVEL_HIGH with GIC_CPU_MASK_SIMPLE.

> +               };
> +
> +               timer {
> +                       compatible = "arm,armv7-timer";
> +                       interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(2) |
> +                                     IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(2) |
> +                                     IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(2) |
> +                                     IRQ_TYPE_LEVEL_LOW)>,
> +                                    <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(2) |
> +                                     IRQ_TYPE_LEVEL_LOW)>;

Likewise.

> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
