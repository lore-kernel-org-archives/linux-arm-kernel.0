From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 20 Jan 2010 21:59:59 -0500
Subject: [PATCH] locomo.c: make irq register access typesafe
In-Reply-To: <f17812d71001201841w34abc3b5w49b8c2986897dbe8@mail.gmail.com>
References: <201001201110.44583.hartleys@visionengravers.com>
	<f17812d71001201813hf93c33wbfc9f50452ec38fa@mail.gmail.com>
	<BD79186B4FD85F4B8E60E381CAEE1909020E8E46@mi8nycmail19.Mi8.com>
	<f17812d71001201841w34abc3b5w49b8c2986897dbe8@mail.gmail.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909020E8E4B@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, January 20, 2010 7:42 PM, Eric Miao wrote:
> On Thu, Jan 21, 2010 at 10:31 AM, H Hartley Sweeten
> <hartleys@visionengravers.com> wrote:
>> On Wednesday, January 20, 2010 7:13 PM, Eric Miao wrote:
>>> On Thu, Jan 21, 2010 at 2:10 AM, H Hartley Sweeten
>>> <hartleys@visionengravers.com> wrote:
>>>> In locomo_setup_irq a void __iomem * is stored by set_irq_chip_data
>>>> to hold the base address for the irq registers. ?Unfortunately chip_data
>>>> is a void *. This will cause a number of (different address space) sparse
>>>> warnings.
>>>>
>>>
>>> That's actually been fixed as a side effect in my previous proposed
>>> irq cleanup patches. The way is to pass locomo chip as the data
>>> instead of a raw pointer. Please let me know how you think, the
>>> specific patch follows:
>>
>> There must be some other patches to locomo.c that remove the locomo_key_*,
>> locomo_gpio_*, locomo_lt_*, and locomo_spi_* related stuff. ?Were all of
>> them merged into common code? ?Where can I find a reference to the
>> original patches?
>>
>
> Cannot find the reference atm but they were posted weeks ago.

Located them at:

http://lists.infradead.org/pipermail/linux-arm-kernel/2009-December/thread.html

I'll try to take a good look at them tomorrow and give you any feedback
I have.

>> Other than that it looks good to me.
>
> Thanks.

Regards,
Hartley
