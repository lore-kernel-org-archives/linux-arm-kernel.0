From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 02 May 2013 21:04:31 +0200
Subject: [PATCH] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <20130502185623.GG14496@n2100.arm.linux.org.uk>
References: <1367519104-19677-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <5182B18C.4080404@gmail.com> <20130502184514.GE14496@n2100.arm.linux.org.uk>
 <5182B65C.8030000@gmail.com> <20130502185623.GG14496@n2100.arm.linux.org.uk>
Message-ID: <5182B8BF.804@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/02/13 20:56, Russell King - ARM Linux wrote:
> On Thu, May 02, 2013 at 08:54:20PM +0200, Sebastian Hesselbarth wrote:
>> On 05/02/13 20:45, Russell King - ARM Linux wrote:
>>> On Thu, May 02, 2013 at 08:33:48PM +0200, Sebastian Hesselbarth wrote:
>>>> On 05/02/2013 08:25 PM, Sebastian Hesselbarth wrote:
>>>>> This patch adds an irqchip driver for the main interrupt controller found
>>>>> on Marvell Orion SoCs (Kirkwood, Dove, Orion5x, Discovery Innovation).
>>>>> Corresponding device tree documentation is also added.
>>>>>
>>>>> Signed-off-by: Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>>>>> ---
>>>>> Note: This patch triggers a checkpatch warning for
>>>>>      WARNING: Avoid CamelCase:<handle_IRQ>
>>>>>
>>>> [...]
>>>>> diff --git a/include/linux/irqchip/orion.h b/include/linux/irqchip/orion.h
>>>>> new file mode 100644
>>>>> index 0000000..04f7bab
>>>>> --- /dev/null
>>>>> +++ b/include/linux/irqchip/orion.h
>>>>> @@ -0,0 +1,18 @@
>>>>> +/*
>>>>> + * Marvell Orion SoCs IRQ chip driver header.
>>>>> + *
>>>>> + * Sebastian Hesselbarth<sebastian.hesselbarth@gmail.com>
>>>>> + *
>>>>> + * This file is licensed under the terms of the GNU General Public
>>>>> + * License version 2.  This program is licensed "as is" without any
>>>>> + * warranty of any kind, whether express or implied.
>>>>> + */
>>>>> +
>>>>> +#ifndef __LINUX_IRQCHIP_ORION_H
>>>>> +#define __LINUX_IRQCHIP_ORION_H
>>>>> +
>>>>> +#include<asm/exception.h>
>>>>
>>>> First review by myself. The above include is a left-over and
>>>> will be removed in a v2.
>>>
>>> You still need your first level IRQ handlers marked with __exception_irq_entry
>>> which is defined in the above file.
>>>
>>
>> Russell,
>>
>> I know and it is marked with __exception_irq_entry. The above is in
>> include/linux/irqchip/orion.h and only used for .init_irq in machine
>> descriptor later.
>>
>> The irq handler is never exposed to the board file itself, but set
>> within orion_init_irq. This approach has been taked by
>> irqchip/irq-gic.c and irqchip/irq-vic.c rather than adding
>> .handle_irq to the machine descriptor.
>
> But I don't find an asm/exception.h include in drivers/irqchip/whateveryour.cfileiscalled
>

Well, that might be because you can magically _see_ compiler warnings
while I have to actually run the compiler ;)

With the review from Jason Gunthorpe things will move anyway and I
expect include/irqchip/orion.h to vanish in v2.

Sebastian
