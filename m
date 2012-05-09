From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 May 2012 11:56:00 +0000
Subject: [PATCH 11/15] drivers/mfd: Enable Device Tree for ab8500-core
 driver
In-Reply-To: <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
References: <1336155805-18554-1-git-send-email-lee.jones@linaro.org>
 <1336155805-18554-12-git-send-email-lee.jones@linaro.org>
 <CACRpkdaju5y6pduWrkH97LujzqJu5hAaGozyHY3Rsvvn7ZyKhA@mail.gmail.com>
Message-ID: <201205091156.00322.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 May 2012, Linus Walleij wrote:
> > +       else if (np)
> > +               ret = of_property_read_u32(np, "stericsson,irq-base", &ab8500->irq_base);
> > +
> > +       if (ab8500->irq_base == 0) {
> 
> Shouldn't this be (av8500->irq_base == NO_IRQ) now that we're tranisitioning to
> use 0 as NO_IRQ?

Since we're into bike-shedding already, why not make it :? :-)

	if (!ab8500->irq_base)

I usually prefer this syntax for testing if something has been assigned,
while I use a comparison with 0 only when it is a meant as a numeric value
rather than meant as validity test.

	Arnd
