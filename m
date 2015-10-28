From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Oct 2015 10:16:19 +0100
Subject: [PATCH v2 1/2] arm64: dts: r8a7795: add GPIO nodes
In-Reply-To: <1445910126-14097-2-git-send-email-horms+renesas@verge.net.au>
References: <1445910126-14097-1-git-send-email-horms+renesas@verge.net.au>
 <1445910126-14097-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdU3gsVc2gW1t=DXLsFS8RqGKiRedZ1vZrr28G6CsQfdbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 27, 2015 at 2:42 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [horms: broken out of a larger patch; moved to soc node]
> [uli: fixed gpio6/7 clocks]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> ---
>
> v2 [Simon Horman]
> * Update for new CPG/MSSR bindings via Geert Uytterhoeven
>
> v1 [Ulrich Hecht]
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 112 +++++++++++++++++++++++++++++++
>  1 file changed, 112 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index b94e5a9e2c3b..68430ccb82e3 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -59,6 +59,118 @@
>                                         (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
>                 };
>
> +               gpio0: gpio at e6050000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6050000 0 0x50>;
> +                       interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 0 32>;

gpio-ranges = <&pfc 0 0 16>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 912>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio1: gpio at e6051000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6051000 0 0x50>;
> +                       interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 32 32>;

gpio-ranges = <&pfc 0 32 28>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 911>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio2: gpio at e6052000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6052000 0 0x50>;
> +                       interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 64 32>;

gpio-ranges = <&pfc 0 64 15>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 910>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio3: gpio at e6053000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6053000 0 0x50>;
> +                       interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 96 32>;

gpio-ranges = <&pfc 0 96 16>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 909>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio4: gpio at e6054000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6054000 0 0x50>;
> +                       interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 128 32>;

gpio-ranges = <&pfc 0 128 18>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 908>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio5: gpio at e6055000 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6055000 0 0x50>;
> +                       interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 160 32>;

gpio-ranges = <&pfc 0 160 26>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 907>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio6: gpio at e6055400 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6055400 0 0x50>;
> +                       interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 192 32>;
> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 906>;
> +                       power-domains = <&cpg>;
> +               };
> +
> +               gpio7: gpio at e6055800 {
> +                       compatible = "renesas,gpio-r8a7795",
> +                                    "renesas,gpio-rcar";
> +                       reg = <0 0xe6055800 0 0x50>;
> +                       interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +                       #gpio-cells = <2>;
> +                       gpio-controller;
> +                       gpio-ranges = <&pfc 0 224 32>;

gpio-ranges = <&pfc 0 224 4>;

> +                       #interrupt-cells = <2>;
> +                       interrupt-controller;
> +                       clocks = <&cpg CPG_MOD 905>;
> +                       power-domains = <&cpg>;
> +               };
> +
>                 timer {
>                         compatible = "arm,armv8-timer";
>                         interrupts = <GIC_PPI 13

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
