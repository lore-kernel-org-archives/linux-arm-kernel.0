From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 May 2016 08:13:28 +0200
Subject: [PATCH v3 5/6] ARM: dts: r8a7794: add sound support
In-Reply-To: <38505966.asxJl6Sq91@wasted.cogentembedded.com>
References: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
 <38505966.asxJl6Sq91@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXdN+nf+_scyDA7yW2NgNiFhK8a1Vt1-uA+FEymoFiPNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 12, 2016 at 10:49 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> @@ -1385,4 +1385,189 @@
>                 #iommu-cells = <1>;
>                 status = "disabled";
>         };
> +
> +       rcar_sound: sound at ec500000 {
> +               /*
> +                * #sound-dai-cells is required
> +                *
> +                * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
> +                * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
> +                */
> +               compatible = "renesas,rcar_sound-r8a7794",
> +                            "renesas,rcar_sound-gen2";
> +               reg =   <0 0xec500000 0 0x1000>, /* SCU */
> +                       <0 0xec5a0000 0 0x100>,  /* ADG */
> +                       <0 0xec540000 0 0x1000>, /* SSIU */
> +                       <0 0xec541000 0 0x280>,  /* SSI */
> +                       <0 0xec740000 0 0x200>;  /* Audio DMAC peri peri */
> +               reg-names = "scu", "adg", "ssiu", "ssi", "audmapp";
> +
> +               clocks = <&mstp10_clks R8A7794_CLK_SSI_ALL>,
> +                        <&mstp10_clks R8A7794_CLK_SSI9>,
> +                        <&mstp10_clks R8A7794_CLK_SSI8>,
> +                        <&mstp10_clks R8A7794_CLK_SSI7>,
> +                        <&mstp10_clks R8A7794_CLK_SSI6>,
> +                        <&mstp10_clks R8A7794_CLK_SSI5>,
> +                        <&mstp10_clks R8A7794_CLK_SSI4>,
> +                        <&mstp10_clks R8A7794_CLK_SSI3>,
> +                        <&mstp10_clks R8A7794_CLK_SSI2>,
> +                        <&mstp10_clks R8A7794_CLK_SSI1>,
> +                        <&mstp10_clks R8A7794_CLK_SSI0>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC9>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC8>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC7>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC6>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC5>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC4>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC3>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC2>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC1>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_SRC0>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_CTU0_MIX0>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_CTU1_MIX1>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_DVC0>,
> +                        <&mstp10_clks R8A7794_CLK_SCU_DVC1>,
> +                        <&audio_clka>, <&audio_clkb>, <&audio_clkc>,
> +                        <&m2_clk>;
> +               clock-names = "ssi-all",
> +                             "ssi.9", "ssi.8", "ssi.7", "ssi.6", "ssi.5",
> +                             "ssi.4", "ssi.3", "ssi.2", "ssi.1", "ssi.0",
> +                             "src.9", "src.8", "src.7", "src.6", "src.5",
> +                             "src.4", "src.3", "src.2", "src.1", "src.0",
> +                             "ctu.0", "ctu.1",
> +                             "mix.0", "mix.1",
> +                             "dvc.0", "dvc.1",
> +                             "clk_a", "clk_b", "clk_c", "clk_i";
> +               power-domains = <&cpg_clocks>;

In renesas-devel-20160509-v4.6-rc7, that should be

        power-domains = <&sysc R8A7794_PD_ALWAYS_ON>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
