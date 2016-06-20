From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 20 Jun 2016 09:53:56 +0200
Subject: [PATCH/RFC 3/3] arm64: dts: r8a7795: Support shared irq for
 thermal sensors
In-Reply-To: <57661CAD.8040807@rvc.renesas.com>
References: <57661211.7010900@rvc.renesas.com>
 <57661BB1.3060401@rvc.renesas.com>
 <57661CAD.8040807@rvc.renesas.com>
Message-ID: <CAMuHMdXvSYFcMzpptrN2AKdeO88P38Ts8-p1CXXYVaGiXvqw5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Khiem,

On Sun, Jun 19, 2016 at 6:16 AM, Khiem Nguyen
<khiem.nguyen.xt@rvc.renesas.com> wrote:
> This patch adds the shared interrupts for thermal sensors
> TSC1/TSC2/TSC3.
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index db203db..761df2b 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -1628,7 +1628,8 @@
>                         compatible = "renesas,thermal-r8a7795",
>                                 "renesas,rcar-gen3-thermal";
>                         reg = <0 0xe6198000 0 0x5c>;
> -                       interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
> +                       interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;

If you make this change, the DT bindings should be updated first.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
