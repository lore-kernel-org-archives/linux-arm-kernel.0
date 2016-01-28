From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 09:21:26 +0100
Subject: [PATCH 2/2] ARM: dts: r8a7794: use GIC_*defines
In-Reply-To: <1453094324-22404-3-git-send-email-horms+renesas@verge.net.au>
References: <1453094324-22404-1-git-send-email-horms+renesas@verge.net.au>
 <1453094324-22404-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWPU0tmMbMw+ygaVd=LpVtNqyFov_7QvVgUA2U4BeTjaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Jan 18, 2016 at 6:18 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Use GIC_* defines for GIC interrupt cells in r8a7794 device tree.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7794.dtsi | 232 ++++++++++++++++++++---------------------
>  1 file changed, 116 insertions(+), 116 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> index f8cd3a0beebf..5d5d8cb41191 100644
> --- a/arch/arm/boot/dts/r8a7794.dtsi
> +++ b/arch/arm/boot/dts/r8a7794.dtsi

> @@ -759,7 +759,7 @@
>                 compatible = "renesas,du-r8a7794";
>                 reg = <0 0xfeb00000 0 0x40000>;
>                 reg-names = "du";
> -               interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
> +               interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,

I've improved my grep skills, and found one more:

>                              <0 268 IRQ_TYPE_LEVEL_HIGH>;

git grep "\<[0-9] [0-9][0-9]* IRQ_TYPE"  --  $(git grep -l renesas, --
arch/arm*/boot/dts)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
