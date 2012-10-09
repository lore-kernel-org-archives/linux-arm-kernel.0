From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Oct 2012 13:45:27 +0200
Subject: [PATCH v3] GPIO: Add support for GPIO on CLPS711X-target platform
In-Reply-To: <1349106153-27371-1-git-send-email-shc_work@mail.ru>
References: <1349106153-27371-1-git-send-email-shc_work@mail.ru>
Message-ID: <CACRpkdbCe00TMxyYVF1kfaturQDDxbNFz3iJe9OhcNNcBCGA4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 1, 2012 at 5:42 PM, Alexander Shiyan <shc_work@mail.ru> wrote:

> The CLPS711X CPUs provide some GPIOs for use in the system. This
> driver provides support for these via gpiolib. Due to platform
> limitations, driver does not support interrupts, only inputs and
> outputs.
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I agree with Russell's comment that all register access macros need
to be pushed down to drivers/gpio/gpio-clps711x.c.

Preferably they should also be replaced by register #defines
and ioremap:ed accesses but I'm not going to be pushy about
that since the driver certainly looks way better after this than
before, so it can be fixed up later.

Yours,
Linus Walleij
