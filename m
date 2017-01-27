From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Jan 2017 11:22:29 +0100
Subject: [PATCH 2/2] arm64: dts: r8a7795: Enable I2C DVFS DMA
In-Reply-To: <1485511583-21614-3-git-send-email-horms+renesas@verge.net.au>
References: <1485511583-21614-1-git-send-email-horms+renesas@verge.net.au>
 <1485511583-21614-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUNqTmLnrgMfLVtmr_h+3r3kaqi+TwTbiQ+Y329ovcvcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 11:06 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -804,6 +804,9 @@
>                         interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&cpg CPG_MOD 926>;
>                         power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
> +                       dmas = <&dmac1 0x11>, <&dmac1 0x10>,
> +                              <&dmac2 0x11>, <&dmac2 0x10>;
> +                       dma-names = "tx", "rx", "tx", "rx";

The datasheet says IIC-DVFS can use dmac0 only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
