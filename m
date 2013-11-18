From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Nov 2013 10:15:36 +0100
Subject: [PATCH 02/10] mtd: st_spi_fsm: Supply all register address and
 bit logic defines
In-Reply-To: <1384438956-31153-3-git-send-email-lee.jones@linaro.org>
References: <1384438956-31153-1-git-send-email-lee.jones@linaro.org>
 <1384438956-31153-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaccxcTfKc-y7rPEH1H3yua3ubLvuvTzWnMs1rOwjiVNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 3:22 PM, Lee Jones <lee.jones@linaro.org> wrote:

> Here we provide the FSM's register addresses, register bit names/offsets
> and some commands which will prove useful as we start bulk the FMS's
> driver out with functionality.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

OK...

> +/*
> + * FSM SPI Controller Registers
> + */
> +#define SPI_CLOCKDIV                   0x0010
> +#define SPI_MODESELECT                 0x0018
> +#define SPI_CONFIGDATA                 0x0020
(...)

So what we want to know here is whether this is a general-purpose
SPI block, or if it's a special-purpose SPI block that can only be
used for accessing flashes.

If it's the former that part should be broken out into drivers/spi
of course...

But the register map seems a bit special-purpose so it could
very well be that this is for flash control only. So maybe you can
spill some beans from a datasheet here?

A clock divider at offset 0x10 already tells us that this is probably
a PL022 derivate, just that we don't know how much it has
been hacked with... does this thing contain AMBA identifiers
at the end of the IO-region, usually at 0x0fe0 thru 0x0fff?

Yours,
Linus Walleij
