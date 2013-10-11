From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Oct 2013 13:13:25 +0200
Subject: [PATCH 1/1] gpio: mvebu: enable and use IRQ_GC_MASK_CACHE_PER_TYPE
In-Reply-To: <1380717259-11060-1-git-send-email-gerlando.falauto@keymile.com>
References: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
 <1380717259-11060-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <CACRpkdayUhwAU7aw7+BZJEjCATAojo-v2bdgM4CwJWH9bkYAdA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 2, 2013 at 2:34 PM, Gerlando Falauto
<gerlando.falauto@keymile.com> wrote:

> Since we have now introduced mask_cache within irq_chip_type to also
> handle per-chip-type mask registers, convert gpio-mvebu driver to use
> this new pointer.
>
> Also enable IRQ_GC_MASK_CACHE_PER_TYPE to actually handle separate mask
> registers for all three SoC variants handled by this driver.
>
> This wll fix a bug where requesting (and triggering) both EDGE- and
> LEVEL- based IRQs causes the kernel to hang.
>
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> Cc: Simon Guinot <sguinot@lacie.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel at lists.infradead.org

Thomas/Gregory: can you comment on this patch?

Yours,
Linus Walleij
