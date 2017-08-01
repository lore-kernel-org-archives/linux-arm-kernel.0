From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 09:53:42 +0200
Subject: [PATCH] gpio: drop unnecessary includes from
 include/linux/gpio/driver.h
In-Reply-To: <1501509867.29303.303.camel@linux.intel.com>
References: <1499140415-31677-1-git-send-email-yamada.masahiro@socionext.com>
 <1499162760.22624.246.camel@linux.intel.com>
 <CACRpkdaxgxaXV8XjLTzu68JqjyeZ8Jr2YMR3L46wm3zmnMrPsg@mail.gmail.com>
 <1501509867.29303.303.camel@linux.intel.com>
Message-ID: <CACRpkdZ9q5vub3sQkA2xsQaZ+CGHeAp4RRueposnTPiHoFbSsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 4:04 PM, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2017-07-31 at 15:48 +0200, Linus Walleij wrote:
>> On Tue, Jul 4, 2017 at 12:06 PM, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Tue, 2017-07-04 at 12:53 +0900, Masahiro Yamada wrote:
>> > > Some of include directives in include/linux/gpio/driver.h are
>> > > unneeded because the header does not need to know the content of
>> > > struct device, irq_chip, etc.  Just declare they are structures.
>> > >
>> > > On the other hand, <linux/irqhandler.h> and
>> > > <linux/spinlock_types.h>
>> > > turned out to be necessary for irq_flow_handler_t and spinlock_t,
>> > > respectively.
>> > >
>> > > Each driver should include what it needs without relying on what
>> > > is
>> > > implicitly included from <linux/gpio/driver.h>.  This will cut
>> > > down
>> > > unnecessary header parsing.
>> >
>> > If Linus is okay with the following proposal I would rather go with
>> > it,
>> > i.e. logical split the series to
>> >
>> > 1. Fix IRQ related headers inclusion
>> > 2. Fix pinconf-generic.h inclusion
>> > 3. Fix OF headers inclusion (btw, of_gpio.h is not enough there?)
>>
>> That works fine with me, but also one big patch actually, I do not
>> want to make it too much work to refactor obviously incorrect things.
>>
>> As soon as we have rough consensus on this and the build robot
>> are happy I will apply it to GPIO and also pull it into the pinctrl
>> subsystem.
>
> For me priorities like this:
> 1) it works after the patch being applied (no regressions);
> 2) it makes code cleaner at the end;
> 3) it is presented in logically split parts.
>
> So, as long as 1) and 2) are satisfied I can neglect on 3).

We are in violent agreement :D

Yours,
Linus Walleij
