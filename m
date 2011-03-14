From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 Mar 2011 09:49:18 +0100
Subject: [PATCH 09/10] ux500: Addressing irq header file dependency for
	snowball.
In-Reply-To: <201103121105.14621.arnd@arndb.de>
References: <1299884892-6766-1-git-send-email-mathieu.poirier@linaro.org>
	<1299884892-6766-10-git-send-email-mathieu.poirier@linaro.org>
	<201103121105.14621.arnd@arndb.de>
Message-ID: <AANLkTi=eLaayDthK8d-SOm1Gu7VfO=cg9c-M-MrSQhpN@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 12, 2011 at 11:05 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 12 March 2011 00:08:11 mathieu.poirier at linaro.org wrote:
>> --- a/arch/arm/mach-ux500/include/mach/irqs.h
>> +++ b/arch/arm/mach-ux500/include/mach/irqs.h
>> @@ -36,7 +36,7 @@
>> ?/* This will be overridden by board-specific irq headers */
>> ?#define IRQ_BOARD_END ? ? ? ? ? ? ? ? ?IRQ_BOARD_START
>>
>> -#ifdef CONFIG_MACH_U8500
>> +#if defined CONFIG_MACH_U8500 || CONFIG_MACH_U8500_SNOWBALL
>> ?#include <mach/irqs-board-mop500.h>
>> ?#endif
>
> Can't you just remove the #ifdef entirely?

Not only that I think, but merge the entire mach/irqs.h into
irqs-board-mop500.h and get rid of mach/irqs.h altogether is the
proper thing to do. The mach/irqs.h only consider that board
family anyway.

There is no reason why we should be broadcasting a few
board-specific irq defines to the entire kernel in mach/

(Surely I can also patch that up later if need be, though,
note to self.)

Yours,
Linus Walleij
