From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Tue, 1 Aug 2017 13:57:59 -0500
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <b79f450d-f4a7-003d-4542-b5d5e4ab4483@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2017 10:53 PM, Masahiro Yamada wrote:
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
>   drivers/gpio/gpio-altera-a10sr.c |  2 ++
>   drivers/gpio/gpio-altera.c       |  3 +++

For the Altera GPIO files:

Acked-by: Thor Thayer <thor.thayer@linux.intel.com>
