From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Aug 2012 11:33:08 +0000
Subject: [PATCH 06/11] gpio: em: do not discard em_gio_irq_domain_cleanup
In-Reply-To: <CACRpkdZnaH3RXHqif7wiA5bor4vOcBndnabG-7QNLnmUc3Oj3Q@mail.gmail.com>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-7-git-send-email-arnd@arndb.de>
 <CACRpkdZnaH3RXHqif7wiA5bor4vOcBndnabG-7QNLnmUc3Oj3Q@mail.gmail.com>
Message-ID: <201208101133.08945.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 10 August 2012, Linus Walleij wrote:
> On Wed, Aug 8, 2012 at 4:47 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > The newly added gpio-em driver marks its em_gio_irq_domain_cleanup
> > function as __devexit, which would lead to that function being
> > discarded in case CONFIG_HOTPLUG is disabled. However, the function
> > is also called by the error handling logic em_gio_probe, which
> > would cause a jump into a NULL pointer if it was removed from the
> > kernel or module.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Will you push this through the ARM SoC tree or do you want me
> to apply it to my GPIO tree?

I'm about to send out the whole series to Torvalds, so I'll just
keep it in now.

	Arnd
