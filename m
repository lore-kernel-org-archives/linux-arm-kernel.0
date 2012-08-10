From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Aug 2012 12:59:32 +0200
Subject: [PATCH 06/11] gpio: em: do not discard em_gio_irq_domain_cleanup
In-Reply-To: <1344437248-20560-7-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-7-git-send-email-arnd@arndb.de>
Message-ID: <CACRpkdZnaH3RXHqif7wiA5bor4vOcBndnabG-7QNLnmUc3Oj3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 4:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The newly added gpio-em driver marks its em_gio_irq_domain_cleanup
> function as __devexit, which would lead to that function being
> discarded in case CONFIG_HOTPLUG is disabled. However, the function
> is also called by the error handling logic em_gio_probe, which
> would cause a jump into a NULL pointer if it was removed from the
> kernel or module.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Will you push this through the ARM SoC tree or do you want me
to apply it to my GPIO tree?

Yours,
Linus Walleij
