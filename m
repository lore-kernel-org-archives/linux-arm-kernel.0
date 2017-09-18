From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 18 Sep 2017 11:26:04 +0200
Subject: [PATCH 7/7] i2c: gpio: Add support for named gpios in DT
In-Reply-To: <20170917093906.16325-8-linus.walleij@linaro.org>
References: <20170917093906.16325-1-linus.walleij@linaro.org>
 <20170917093906.16325-8-linus.walleij@linaro.org>
Message-ID: <CAMuHMdX4+e6D_AEdvVF2Ubyxs0L6-53fqwot=wDXfPatvnMGTg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 17, 2017 at 11:39 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This adds support for using the "sda" and "scl" GPIOs in
> device tree instead of anonymously using index 0 and 1 of
> the "gpios" property.
>
> We add a helper function to retrieve the GPIO descriptors
> and some explicit error handling since the probe may have
> to be deferred. At least this happened to me when moving
> to using named "sda" and "scl" lines (all of a sudden this
> started to probe before the GPIO driver) so we need to
> gracefully defer probe when we ge -ENOENT in the error

get

> pointer.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
