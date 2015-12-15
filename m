From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 15 Dec 2015 11:44:24 +0100
Subject: [PATCH 2/6] arm64: dts: r8a7795: Add SATA controller node
In-Reply-To: <1450107758-2544-3-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1450107758-2544-3-git-send-email-ulrich.hecht+renesas@gmail.com>
Message-ID: <CAMuHMdXq1uT69w6bnqJM49vgoDzax=hte+OM3MDahcBuUfD9Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 4:42 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index c018423..7d4707e 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -972,5 +972,13 @@
>                                 };
>                         };
>                 };
> +
> +               sata: sata at ee300000 {
> +                       compatible = "renesas,sata-r8a7795";
> +                       reg = <0 0xee300000 0 0x1fff>;
> +                       interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 915>;

My datasheet says 815.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
