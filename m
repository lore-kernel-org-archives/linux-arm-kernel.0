From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 18:26:50 +0200
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <201204181622.34692.arnd@arndb.de>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <1334659448-11521-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdaUDBwHb24eALidivgZGJS=xBpXNoYJUcAWrzCwYqi2ag@mail.gmail.com>
 <201204181622.34692.arnd@arndb.de>
Message-ID: <CACRpkdaTFatBK4GyzCzm=U6+h8Knnf6xY9X6Uc26sLxQb2OhtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 6:22 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The problem is that we cannot put the interrupt resources into the platform
> device until the irq domain has been added. Right now, we set the gic
> interrupt domain from init_IRQ(), then add the load the gpio
> driver from core_initcall(nmk_gpio_init) and add the platform devices
> from arch_initcall(customize_machine).
>
> This feels fragile because it depends on the gpio device getting probed
> before any device using the gpio interrupts. It does seem to work fine
> right now, but I'm not convinced that this is just coincidence.

Aha OK. Why not put in that big comment then, thus nobody will
ever miss the point like I did :-)

Thanks!
Linus Walleij
