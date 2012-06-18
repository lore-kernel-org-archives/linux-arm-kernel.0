From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 18 Jun 2012 13:47:32 +0200
Subject: [PATCH] spi: spi-pl022: Adjust probe() to of_get_named_gpio()
 returning -EPROBE_DEFER
In-Reply-To: <1340011219-31657-1-git-send-email-stigge@antcom.de>
References: <1340011219-31657-1-git-send-email-stigge@antcom.de>
Message-ID: <CACRpkdYTE0imxEAdq0=wJO49iBAj=8xGjn_PevFm1Bsr3MvUQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 11:20 AM, Roland Stigge <stigge@antcom.de> wrote:

> The patch to gpiolib-of.c providing -EPROBE_DEFER as a hint to defer
> of_get_named_gpio*() to a later probe() breaks spi-pl022.c.
>
> This patch adjusts to this change, using -EPROBE_DEFER as indication to defer.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

> Should this patch be joined with gpiolib-of's patch to of_get_named_gpio()? Or
> should they just be issued as a series?

If it's not bisectable unless you change this in the same patch then join
them. Else I'd put them in a series and try to figure out a good tree for
merging them.

Yours,
Linus Walleij
