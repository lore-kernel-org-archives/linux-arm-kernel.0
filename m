From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Jan 2016 09:56:43 +0100
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: use GIC_* defines
In-Reply-To: <1451856807-8081-3-git-send-email-horms+renesas@verge.net.au>
References: <1451856807-8081-1-git-send-email-horms+renesas@verge.net.au>
 <1451856807-8081-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWH6Hi4yU0gYfxmyCDF3JNZiii00SwiNrZomQ_-pWbkdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Sun, Jan 3, 2016 at 10:33 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use GIC_* defines for GIC interrupt cells in r8a7791 device tree.

Thanks for doing this!

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 370 ++++++++++++++++++++---------------------
>  1 file changed, 185 insertions(+), 185 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 2a369ddcb6fd..c24276375c53 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi

> @@ -782,7 +782,7 @@
>         ether: ethernet at ee700000 {
>                 compatible = "renesas,ether-r8a7791";
>                 reg = <0 0xee700000 0 0x400>;
> -               interrupts = <0 162 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
>                 clocks = <&mstp8_clks R8A7791_CLK_ETHER>;
>                 power-domains = <&cpg_clocks>;
>                 phy-mode = "rmii";
> @@ -806,7 +806,7 @@

You forgot to update the avb node in between these two chunks.

> @@ -1577,9 +1577,9 @@
>                 /* Map all possible DDR as inbound ranges */
>                 dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
>                               0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
> -               interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>,
> -                            <0 117 IRQ_TYPE_LEVEL_HIGH>,
> -                            <0 118 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
> +                            <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>                 #interrupt-cells = <1>;
>                 interrupt-map-mask = <0 0 0 0>;
>                 interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;

You forgot to update the "interrupt-map" properties in the various PCI nodes
(the "0" after the "&gic").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
