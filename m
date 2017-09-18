From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Sep 2017 11:11:31 +0200
Subject: [PATCH 5/7] i2c: gpio: Local vars in probe
In-Reply-To: <20170917093906.16325-6-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-6-linus.walleij@linaro.org>
Message-ID: <CAMuHMdX=AyJ2JVSBO8YwcfCMxEFAwEHe7Wxd_d4OreZaWFoF=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> By creating local variables for *dev and *np, the code become
> much easier to read, in my opinion.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I put this at the end of the series because compared to the
> rest of the patches it is completely unimportant.
> ---
>  drivers/i2c/busses/i2c-gpio.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index 97b9c29e9429..beb5ce523684 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c

> @@ -99,15 +101,15 @@ static int i2c_gpio_probe(struct platform_device *pdev)
>         bit_data = &priv->bit_data;
>         pdata = &priv->pdata;
>
> -       if (pdev->dev.of_node) {
> -               of_i2c_gpio_get_props(pdev->dev.of_node, pdata);
> +       if (np) {
> +               of_i2c_gpio_get_props(np, pdata);
>         } else {
>                 /*
>                  * If all platform data settings are zero it is OK
>                  * to not provide any platform data from the board.
>                  */
> -               if (dev_get_platdata(&pdev->dev))
> -                       memcpy(pdata, dev_get_platdata(&pdev->dev),
> +               if (dev_get_platdata(dev))
> +                       memcpy(pdata, dev_get_platdata(dev),
>                                sizeof(*pdata));

This fits on one line again (you have to do something to offset the LoC
increase 14 insertions(+), 12 deletions(-) ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
