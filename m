From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 03 Sep 2014 10:44:12 +0100
Subject: [PATCH v11 06/19] irqchip: gic: Provide support for interrupt
 grouping
In-Reply-To: <CBF5C246-DBB2-4FC3-A507-CA3E15013F7C@arm.com>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-7-git-send-email-daniel.thompson@linaro.org>
 <20140902193355.GW30401@n2100.arm.linux.org.uk>
 <CBF5C246-DBB2-4FC3-A507-CA3E15013F7C@arm.com>
Message-ID: <5406E2EC.4050201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/14 22:36, Catalin Marinas wrote:
> On 2 Sep 2014, at 20:33, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Tue, Sep 02, 2014 at 02:00:40PM +0100, Daniel Thompson wrote:
>>> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
>>> index 4b959e6..423707c 100644
>>> --- a/drivers/irqchip/irq-gic.c
>>> +++ b/drivers/irqchip/irq-gic.c
>>> @@ -41,6 +41,9 @@
>>> #include <linux/irqchip/arm-gic.h>
>>>
>>> #include <asm/cputype.h>
>>> +#ifdef CONFIG_FIQ
>>> +#include <asm/fiq.h>
>>> +#endif
>>
>> Is there much advantage to this ifdef over providing a dummy asm/fiq.h
>> in ARM64?
> 
> While it?s unlikely we?ll use FIQs on arm64 (they are generally
> reserved for the secure world/firmware), I don?t mind an empty
> asm/fiq.h file.

Thanks Catalin, Thanks Russell.

I will do this.
