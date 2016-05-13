From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 May 2016 08:12:37 +0200
Subject: [PATCH v3 4/6] ARM: dts: r8a7794: add Audio-DMAC support
In-Reply-To: <25671875.9c5xSSzmjj@wasted.cogentembedded.com>
References: <2378837.cigT3tNQPe@wasted.cogentembedded.com>
 <25671875.9c5xSSzmjj@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUqys5qFShjfTfBn8sK1xs=+q91QFnvmS59GK_PqTByNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, May 12, 2016 at 10:47 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> @@ -295,6 +295,34 @@
>                 dma-channels = <15>;
>         };
>
> +       audma0: dma-controller at ec700000 {
> +               compatible = "renesas,dmac-r8a7794", "renesas,rcar-dmac";
> +               reg = <0 0xec700000 0 0x10000>;
> +               interrupts =    <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
> +                                GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "error",
> +                                 "ch0", "ch1", "ch2", "ch3", "ch4", "ch5",
> +                                 "ch6", "ch7", "ch8", "ch9", "ch10", "ch11",
> +                                 "ch12";
> +               clocks = <&mstp5_clks R8A7794_CLK_AUDIO_DMAC0>;
> +               clock-names = "fck";
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
