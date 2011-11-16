From: zonque@gmail.com (Daniel Mack)
Date: Wed, 16 Nov 2011 16:30:33 +0100
Subject: [PATCH] ARM: pxa: fix missing linux/gpio.h include
In-Reply-To: <CAMPhdO-jKNsVnHh7m3G19wETd5+8XVkjSvyAoEANJ3rS0USaUg@mail.gmail.com>
References: <1321454103-26596-1-git-send-email-zonque@gmail.com>
 <CAN1soZw4zPCe-VzbXjmGJ6+9yRF3H6KEPtp7kQGa3CtBPHUbfQ@mail.gmail.com>
 <CAMPhdO-jKNsVnHh7m3G19wETd5+8XVkjSvyAoEANJ3rS0USaUg@mail.gmail.com>
Message-ID: <4EC3D719.60704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2011 04:08 PM, Eric Miao wrote:
> On Wed, Nov 16, 2011 at 11:03 PM, Haojian Zhuang
> <haojian.zhuang@gmail.com> wrote:
>> On Wed, Nov 16, 2011 at 10:35 PM, Daniel Mack <zonque@gmail.com> wrote:
>>> Fixes the following compile error:
>>>
>>>  arch/arm/mach-pxa/pxa3xx.c: In function 'pxa3xx_cpu_pm_suspend':
>>>  arch/arm/mach-pxa/pxa3xx.c:156: error: implicit declaration of function 'gpio_get_value'
>>>  make[1]: *** [arch/arm/mach-pxa/pxa3xx.o] Error 1
>>>
>>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>>> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
>>> Cc: Eric Miao <eric.y.miao@gmail.com>
>>> ---
>>>
>>>  I didn't closely follow all recent patches around PXA, so it might be that
>>>  this has already been cared for. Haojian?
>>>
>>>  arch/arm/mach-pxa/pxa3xx.c |    1 +
>>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
>>> index 3866d52..7cddd11 100644
>>> --- a/arch/arm/mach-pxa/pxa3xx.c
>>> +++ b/arch/arm/mach-pxa/pxa3xx.c
>>> @@ -19,6 +19,7 @@
>>>  #include <linux/platform_device.h>
>>>  #include <linux/irq.h>
>>>  #include <linux/io.h>
>>> +#include <linux/gpio.h>
>>>  #include <linux/syscore_ops.h>
>>>  #include <linux/i2c/pxa-i2c.h>
>>>
>>> --
>>> 1.7.7.1
>>>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>>
>>
>> Hi Daniel,
>>
>> At first, gpio_get_value() isn't used in arch/arm/mach-pxa/pxa3xx.c.
>>
>> Which git tree and which branch are you using now? I tried my git
>> tree, arnd/for-next, rmk/for-next. Everything is ok. I can't find any
>> build issue.
> 
> Ouch! I didn't even give it a second thought to this obvious one-liner patch.

Gash. Not my day. We have a stupid workaround in that file that is
buried in a very old patch. Due to recent changes in mainline, this
doesn't build anymore, but that is something I have to keep privately.

Thanks for the heads-up, and sorry. You can drop this patch.


Daniel
