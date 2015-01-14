From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 14 Jan 2015 10:35:29 +0100
Subject: [PATCH 1/5] ARM: sa1100: split irq handling for low GPIOs
In-Reply-To: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
References: <1419242740-20219-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <CACRpkdavZdZuYxLW-i4BJM0hFqt73n7AhrSzUynBsuDNj5HKGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 11:05 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Low GPIO pins use an interrupt in SC interrupts space. However it's
> possible to handle them as if all the GPIO interrupts are instead tied
> to single GPIO handler, which later decodes GEDR register and
> chain-calls next IRQ handler. So split first 11 interrupts into system
> part (IRQ_GPIO0_SC - IRQ_GPIO10_SC) which work exactly like the rest of
> system controller interrupts and real GPIO interrupts
> (IRQ_GPIO0..IRQ_GPIO10). A single handler sa1100_gpio_handler then
> decodes and calls next handler.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

I applied all 5 patches and tested on the Compaq iPAQ H3600
with some GPIO lines with IRQs and all work as before.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
for all 5 patches.

Yours,
Linus Walleij
