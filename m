From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 5 Jul 2017 15:47:13 +0200
Subject: [PATCH v 1/2] ravb: Add support for r8a7743 SoC
In-Reply-To: <1499259711-56175-2-git-send-email-biju.das@bp.renesas.com>
References: <1499259711-56175-1-git-send-email-biju.das@bp.renesas.com>
 <1499259711-56175-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <CAMuHMdVMunZ0trcNmMg4KkEd+d88foep7C0kU=yLQNk5JojosA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Biju,

On Wed, Jul 5, 2017 at 3:01 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> Add support for Gigabit Ethernet E-MAC on r8a7743 (RZ/G1M) SoC.
> Renesas RZ/G1M (R8A7743) SoC Ethernet AVB IP is identical to the R-Car Gen2
> family.
>
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>

Thanks for your patch!

> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1869,6 +1869,7 @@ static int ravb_mdio_release(struct ravb_private *priv)
>  }
>
>  static const struct of_device_id ravb_match_table[] = {
> +       { .compatible = "renesas,etheravb-r8a7743", .data = (void *)RCAR_GEN2 },
>         { .compatible = "renesas,etheravb-r8a7790", .data = (void *)RCAR_GEN2 },
>         { .compatible = "renesas,etheravb-r8a7794", .data = (void *)RCAR_GEN2 },
>         { .compatible = "renesas,etheravb-rcar-gen2", .data = (void *)RCAR_GEN2 },

As Sergei already mentioned, a driver update is not needed due to the
presence of family-specific compatible values.
Please drop that part, and you can add my:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
