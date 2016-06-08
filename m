From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 8 Jun 2016 09:05:54 +0200
Subject: [PATCH v2 05/11] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <2268000.l71DRbJSRE@wasted.cogentembedded.com>
References: <3446154.oZ24315zaL@wasted.cogentembedded.com>
 <2268000.l71DRbJSRE@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUMQZGg_hy0WOgwJMZhDCsKt-XJvnX0tq6i=92qubOAUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Jun 3, 2016 at 11:26 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The initial R8A7792 SoC device tree including CPU core, GIC, timer, SYSC,
> and the required  clock descriptions.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> Changes in version 2:

> - created  the "soc" subnode, moving the SoC  device  nodes there;
> - removed  the "clocks" node, moving its fixed clock  subnodes to the root and
>   the MSTP subnodes into the "soc" node.
>
>  arch/arm/boot/dts/r8a7792.dtsi |  171 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 171 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi

> +       /* Fixed factor clocks */
> +       zs_clk: zs {
> +               compatible = "fixed-factor-clock";
> +               clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
> +               #clock-cells = <0>;
> +               clock-div = <6>;
> +               clock-mult = <1>;
> +       };
> +       p_clk: p {
> +               compatible = "fixed-factor-clock";
> +               clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
> +               #clock-cells = <0>;
> +               clock-div = <24>;
> +               clock-mult = <1>;
> +       };
> +       cp_clk: cp {
> +               compatible = "fixed-factor-clock";
> +               clocks = <&cpg_clocks R8A7792_CLK_PLL1>;
> +               #clock-cells = <0>;
> +               clock-div = <3>;
> +               clock-mult = <1>;
> +       };

I think the above 3 fixed factor clocks should be children of the "soc" node,
as they're generated on-SoC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
