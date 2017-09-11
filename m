From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 11 Sep 2017 13:27:59 +0200
Subject: [PATCH 1/5] i2c: gpio: Convert to use descriptors
In-Reply-To: <20170910214424.14945-2-linus.walleij@linaro.org>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-2-linus.walleij@linaro.org>
Message-ID: <CAMuHMdXabvax2Wru8j+MC4X5F+z5hoUo1tEbX+zn2AUW6QENVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Sep 10, 2017 at 11:44 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> This converts the GPIO-based I2C-driver to using GPIO
> descriptors instead of the old global numberspace-based
> GPIO interface. We:
>
> - Convert the driver to unconditionally grab two GPIOs
>   from the device by index 0 (SDA) and 1 (SCL) which
>   will work fine with device tree and descriptor tables.
>   The existing device trees will continue to work just
>   like before, but without any roundtrip through the
>   global numberspace.

FYI, I recently posted a series to deprecate (at least for DT) this error
prone indexing, in favor of using named GPIOs:

    [PATCH/RFC 0/3] i2c: gpio: Add support for named gpios in DT
    http://www.spinics.net/lists/devicetree/msg191936.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
