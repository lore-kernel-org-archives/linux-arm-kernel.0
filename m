From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 03 Jul 2014 19:39:49 +0200
Subject: [PATCH 2/3] clocksource: add device-tree support for PXA timer
In-Reply-To: <87tx6ynybb.fsf@free.fr> (Robert Jarzmik's message of "Thu, 03
 Jul 2014 19:31:52 +0200")
References: <1403388588-11956-1-git-send-email-robert.jarzmik@free.fr>
 <1403388588-11956-2-git-send-email-robert.jarzmik@free.fr>
 <53B5470D.4070009@linaro.org> <87tx6ynybb.fsf@free.fr>
Message-ID: <87pphmnxy2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
>
>>> -#include <mach/regs-ost.h>
>>>   #include <mach/irqs.h>
>>> +#include <mach/hardware.h>
>>
>> Now as the driver is in 'drivers', do not reference the headers files in
>> mach. Moving the driver to the drivers directory implies some cleanup with the
>> headers dependencies.
> I don't see that very possible.
> Or said another way, I don't see how the irq number, IRQ_OST0 (in mach/irqs.h)
> can be guessed for non device-tree configuration.
Oh yeah, a simple parameter to pxa_init_timer() will do the trick ...

> Another question brought up by this : if I remove all 'mach/' includes, I loose
> io_p2v() right ? How can I guess timer_base then ?
And same answer here, a simple parameter to pxa_init_timer() will solve this
too.

Cheers.

--
Robert
