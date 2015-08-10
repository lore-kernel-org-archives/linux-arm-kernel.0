From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Aug 2015 16:35:32 +0200
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add QSPI DT support
In-Reply-To: <5339616.vfIYf6AeR8@wasted.cogentembedded.com>
References: <1898263.zrOs5SAUTS@wasted.cogentembedded.com>
 <5339616.vfIYf6AeR8@wasted.cogentembedded.com>
Message-ID: <CAMuHMdX3F4ecR=BjgUrrEA3P4xpu-Yt_r3qM6SgUdFrYm7h1Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 9, 2015 at 12:26 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A7794 part of the QSPI device node.
>
> Based on original patch by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

 arch/arm/boot/dts/r8a7794.dtsi |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7794.dtsi
> @@ -19,6 +19,10 @@
>         #address-cells = <2>;
>         #size-cells = <2>;
>
> +       aliases {
> +               spi0 = &qspi;
> +       };
> +
>         cpus {
>                 #address-cells = <1>;
>                 #size-cells = <0>;
> @@ -537,6 +541,20 @@
>                 status = "disabled";
>         };
>
> +       qspi: spi at e6b10000 {
> +               compatible = "renesas,qspi-r8a7794", "renesas,qspi";
> +               reg = <0 0xe6b10000 0 0x2c>;
> +               interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&mstp9_clks R8A7794_CLK_QSPI_MOD>;
> +               power-domains = <&cpg_clocks>;

For consistency with the other nodes, I'd add "power-domains" below the
DMA-related properties.

> +               dmas = <&dmac0 0x17>, <&dmac0 0x18>;
> +               dma-names = "tx", "rx";
> +               num-cs = <1>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               status = "disabled";
> +       };
> +
>         clocks {
>                 #address-cells = <2>;
>                 #size-cells = <2>;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
