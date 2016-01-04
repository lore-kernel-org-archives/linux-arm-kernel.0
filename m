From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Jan 2016 09:53:47 +0100
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: use GIC_* defines
In-Reply-To: <1451856807-8081-2-git-send-email-horms+renesas@verge.net.au>
References: <1451856807-8081-1-git-send-email-horms+renesas@verge.net.au>
 <1451856807-8081-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW_b0DSn1x29r-0sdWsF47JyxAWKpN7JG025RTmB0aOuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Sun, Jan 3, 2016 at 10:33 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use GIC_* defines for GIC interrupt cells in r8a7791 device tree.

Thanks a lot for doing this!

> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 348 ++++++++++++++++++++---------------------
>  1 file changed, 174 insertions(+), 174 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 7dfd393bfc7e..fd732bd942a3 100644

> @@ -1580,9 +1580,9 @@
>                 /* Map all possible DDR as inbound ranges */
>                 dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
>                               0x43000000 1 0x80000000 1 0x80000000 0 0x80000000>;
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
