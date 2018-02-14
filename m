From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 14 Feb 2018 15:05:05 +0100
Subject: [PATCH 11/15] gpio: rcar: Add R-Car M3-N compatible string
In-Reply-To: <1518515162-23663-12-git-send-email-jacopo+renesas@jmondi.org>
References: <1518515162-23663-1-git-send-email-jacopo+renesas@jmondi.org>
 <1518515162-23663-12-git-send-email-jacopo+renesas@jmondi.org>
Message-ID: <CAMuHMdXW-7+6_iSPk3oUo-fWsMxqvSawuy2QZ3VTYhoeN8kB4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 10:45 AM, Jacopo Mondi
<jacopo+renesas@jmondi.org> wrote:
> Add compatible string for R-Car M3-N (r8a77965) in gpio-rcar.
>
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -360,6 +360,10 @@ static const struct of_device_id gpio_rcar_of_table[] = {
>                 /* Gen3 GPIO is identical to Gen2. */
>                 .data = &gpio_rcar_info_gen2,
>         }, {
> +               .compatible = "renesas,gpio-r8a77965",
> +               /* Gen3 GPIO is identical to Gen2. */
> +               .data = &gpio_rcar_info_gen2,
> +       }, {

This part is not needed, as the driver already matches agains the generic
"renesas,rcar-gen3-gpio".

>                 .compatible = "renesas,rcar-gen1-gpio",
>                 .data = &gpio_rcar_info_gen1,
>         }, {

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
