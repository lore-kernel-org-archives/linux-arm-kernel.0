From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 Feb 2016 10:54:19 +0100
Subject: [PATCH 1/2] can: rcar_can: Add r8a7795 support
In-Reply-To: <1456737661-20538-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-2-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Message-ID: <CAMuHMdV3EsvN=sqiB2npB=cH8Bz4D6UVcQj-BKqfdHerKSDowQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ramesh,

On Mon, Feb 29, 2016 at 10:21 AM, Ramesh Shanmugasundaram
<ramesh.shanmugasundaram@bp.renesas.com> wrote:
> --- a/drivers/net/can/rcar_can.c
> +++ b/drivers/net/can/rcar_can.c
> @@ -808,6 +808,10 @@ static int rcar_can_probe(struct platform_device *pdev)
>         priv->regs = addr;
>         priv->clock_select = clock_select;
>         priv->can.clock.freq = clk_get_rate(priv->can_clk);
> +
> +       /* Use the rounded clock value (nearest kHz) */
> +       priv->can.clock.freq = 1000 * DIV_ROUND_UP(priv->can.clock.freq, 1000);

The comment and the implementation don't match.
To get the nearest kHz, you have to useDIV_ROUND_CLOSEST().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
