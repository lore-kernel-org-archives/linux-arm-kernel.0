From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Apr 2012 08:47:14 +0200
Subject: [PATCH 02/16] drivers/gpio: gpio-nomadik: Add support for
 irqdomains
In-Reply-To: <201204191623.07445.arnd@arndb.de>
References: <1334659448-11521-1-git-send-email-lee.jones@linaro.org>
 <201204181622.34692.arnd@arndb.de>
 <CACRpkdaTFatBK4GyzCzm=U6+h8Knnf6xY9X6Uc26sLxQb2OhtA@mail.gmail.com>
 <201204191623.07445.arnd@arndb.de>
Message-ID: <CACRpkdZGBndSvuFa=cFfsd5swW6+mD+PuGESobdEQ4j6oALQQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 19, 2012 at 6:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> If we move the code that adds the resources to a platform_device
> from of_device_alloc() to ?platform_drv_probe(), we can defer
> looking up the interrupt number until the driver actually gets
> probed and bail out early with -EPROBE_DEFER if the irq domain
> is not available yet. That will even work when we have a builtin
> driver for a device that uses a GPIO interrupt and the gpio controller
> driver is a loadable module.

Sounds like a good idea, we just need to make sure that the
corresponding AMBA/PrimeCell devices doesn't end up with different
semantics because of this.

So might need some patching around that bus as well.

Yours,
Linus Walleij
