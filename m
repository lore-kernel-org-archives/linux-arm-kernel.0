From: vilhelm.gray@gmail.com (William Breathitt Gray)
Date: Tue, 4 Jul 2017 08:58:51 -0400
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170704125851.GA20504@sophia>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 12:53:34PM +0900, Masahiro Yamada wrote:
>Some of include directives in include/linux/gpio/driver.h are
>unneeded because the header does not need to know the content of
>struct device, irq_chip, etc.  Just declare they are structures.
>
>On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
>turned out to be necessary for irq_flow_handler_t and spinlock_t,
>respectively.
>
>Each driver should include what it needs without relying on what is
>implicitly included from <linux/gpio/driver.h>.  This will cut down
>unnecessary header parsing.
>
>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> drivers/gpio/gpio-104-dio-48e.c  |  1 +
> drivers/gpio/gpio-104-idi-48.c   |  1 +
> drivers/gpio/gpio-104-idio-16.c  |  1 +
> drivers/gpio/gpio-pci-idio-16.c  |  2 ++
> drivers/gpio/gpio-ws16c48.c      |  1 +

The changes to the above drivers look fine to me:

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

However, this patch as a whole does too many things; I'd like to see it
split-up logically similar to how Andy Shevchenko suggested in his
reply. That should allow ACKs by respective driver maintainers to be
accounted more properly.

William Breathitt Gray
