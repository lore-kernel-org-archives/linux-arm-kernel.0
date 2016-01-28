From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 09:15:50 +0100
Subject: [PATCH] ARM: dts: emev2:use GIC_* defines
In-Reply-To: <1453944594-24757-1-git-send-email-horms+renesas@verge.net.au>
References: <1453944594-24757-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVBK1nGiYucbDA8SKTLtVd7yC6v1oq==fnzP9Fq2cWhfw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Jan 28, 2016 at 2:29 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use GIC_* defines for GIC interrupt cells in emev2 device tree.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> Based on renesas-devel-20160127-v4.5-rc1
> ---
>  arch/arm/boot/dts/emev2.dtsi | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
> index 57795da616cb..366e822367c7 100644
> --- a/arch/arm/boot/dts/emev2.dtsi
> +++ b/arch/arm/boot/dts/emev2.dtsi
> @@ -9,6 +9,7 @@
>   */
>
>  #include "skeleton.dtsi"
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
> @@ -53,7 +54,7 @@
>
>         pmu {
>                 compatible = "arm,cortex-a9-pmu";
> -               interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
> +               interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
>                              <0 121 IRQ_TYPE_LEVEL_HIGH>;

If you convert the above line, too, you can add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
