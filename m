From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 16:40:34 +0100
Subject: [PATCH v2 03/19] soc: renesas: Identify R-Car M3-N
In-Reply-To: <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
References: <1519139541-18783-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519139541-18783-4-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdVw4OSPP7XYLGuE7SfVjOk_6VK847NdsVwszBX9XshQ3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacopo,

On Tue, Feb 20, 2018 at 4:12 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> Add support for indentifying R-Car M3-N (R8A77965) SoC.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/soc/renesas/renesas-soc.c
> +++ b/drivers/soc/renesas/renesas-soc.c
> @@ -149,6 +149,11 @@ static const struct renesas_soc soc_rcar_v3m __initconst __maybe_unused = {
>         .id     = 0x54,
>  };
>
> +static const struct renesas_soc soc_rcar_m3_n __initconst __maybe_unused = {
> +       .family = &fam_rcar_gen3,
> +       .id     = 0x55,
> +};

Note that the list was sorted by SoC part number.

> +
>  static const struct renesas_soc soc_rcar_v3h __initconst __maybe_unused = {
>         .family = &fam_rcar_gen3,
>         .id     = 0x56,
> @@ -214,6 +219,9 @@ static const struct of_device_id renesas_socs[] __initconst = {
>  #ifdef CONFIG_ARCH_R8A7796
>         { .compatible = "renesas,r8a7796",      .data = &soc_rcar_m3_w },
>  #endif
> +#ifdef CONFIG_ARCH_R8A77965
> +       { .compatible = "renesas,r8a77965",     .data = &soc_rcar_m3_n },
> +#endif
>  #ifdef CONFIG_ARCH_R8A77970
>         { .compatible = "renesas,r8a77970",     .data = &soc_rcar_v3m },
>  #endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
