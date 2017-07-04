From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Tue, 4 Jul 2017 09:30:45 +0100
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170704083045.fqruqn6i5sxhfhu6@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 04, 2017 at 12:53:34PM +0900, Masahiro Yamada wrote:
> Some of include directives in include/linux/gpio/driver.h are
> unneeded because the header does not need to know the content of
> struct device, irq_chip, etc.  Just declare they are structures.
> 
> On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
> turned out to be necessary for irq_flow_handler_t and spinlock_t,
> respectively.
> 
> Each driver should include what it needs without relying on what is
> implicitly included from <linux/gpio/driver.h>.  This will cut down
> unnecessary header parsing.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/gpio/gpio-wm831x.c       |  1 +
>  drivers/gpio/gpio-wm8994.c       |  1 +

For the Wolfson Micro bits:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
