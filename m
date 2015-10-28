From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 28 Oct 2015 09:22:34 +0100
Subject: [PATCH v12 1/7] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC
 support
In-Reply-To: <1445839312-8874-2-git-send-email-horms+renesas@verge.net.au>
References: <1445839312-8874-1-git-send-email-horms+renesas@verge.net.au>
 <1445839312-8874-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdWrR0it7pgxQr1e+55GwuXszh8kNUQ3+dyy6WjVJe2+9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 7:01 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
>
> Initial version of Renesas R-Car H3 support (V10)
>
> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> new file mode 100644
> index 000000000000..aa13115387a6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi

> +       extal_clk: extal {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;

I would add the same override comment as for extalr here, too.

> +               clock-frequency = <0>;
> +       };
> +
> +       extalr_clk: extalr {
> +               compatible = "fixed-clock";
> +               #clock-cells = <0>;
> +               /* This value must be overridden by the board */
> +               clock-frequency = <0>;
> +       };

Nevertheless:

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
