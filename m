From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Jan 2017 11:22:10 +0100
Subject: [PATCH 1/2] arm64: dts: r8a7796: Enable I2C DVFS DMA
In-Reply-To: <1485511583-21614-2-git-send-email-horms+renesas@verge.net.au>
References: <1485511583-21614-1-git-send-email-horms+renesas@verge.net.au>
 <1485511583-21614-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWme2UTtzf4R-VzL0kGb=AnBXK4QGF2boCehnZxVuDswg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Jan 27, 2017 at 11:06 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> index c95ad177b097..c8592d05620b 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> @@ -280,6 +280,9 @@
>                         interrupts = <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH>;
>                         clocks = <&cpg CPG_MOD 926>;
>                         power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
> +                       dmas = <&dmac1 0x11>, <&dmac1 0x10>,
> +                              <&dmac2 0x11>, <&dmac2 0x10>;
> +                       dma-names = "tx", "rx", "tx", "rx";

Have you actually tried this?

The datasheet says IIC-DVFS can use dmac0 only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
