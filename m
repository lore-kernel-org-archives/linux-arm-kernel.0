From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 4 Jul 2017 19:39:28 +0900
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1499162760.22624.246.camel@linux.intel.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
 <1499162760.22624.246.camel@linux.intel.com>
Message-ID: <CAK7LNASmcg5CZ5OSBxakZ2LZgDe1F3RDEtvJ5F9Tk29pXrbQxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-07-04 19:06 GMT+09:00 Andy Shevchenko <andriy.shevchenko@linux.intel.com>:
> On Tue, 2017-07-04 at 12:53 +0900, Masahiro Yamada wrote:
>> Some of include directives in include/linux/gpio/driver.h are
>> unneeded because the header does not need to know the content of
>> struct device, irq_chip, etc.  Just declare they are structures.
>>
>> On the other hand, <linux/irqhandler.h> and <linux/spinlock_types.h>
>> turned out to be necessary for irq_flow_handler_t and spinlock_t,
>> respectively.
>>
>> Each driver should include what it needs without relying on what is
>> implicitly included from <linux/gpio/driver.h>.  This will cut down
>> unnecessary header parsing.
>
> If Linus is okay with the following proposal I would rather go with it,
> i.e. logical split the series to
>
> 1. Fix IRQ related headers inclusion
> 2. Fix pinconf-generic.h inclusion
> 3. Fix OF headers inclusion (btw, of_gpio.h is not enough there?)

Maybe
  4.  Fix (platform_)device inclusion


But, I do not see much sense to touch headers multiple times.



-- 
Best Regards
Masahiro Yamada
