From: zourongrong@gmail.com (Rongrong Zou)
Date: Wed, 13 Jan 2016 14:34:47 +0800
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <1452664413.2403.20.camel@kernel.crashing.org>
References: <568912EE.9030009@huawei.com> <5694E9FF.6030904@huawei.com>
 <20160112151335.GS13633@e106497-lin.cambridge.arm.com>
 <4731036.9QlepWb5cE@wuerfel> <1452664413.2403.20.camel@kernel.crashing.org>
Message-ID: <5695F007.3070005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/13 13:53, Benjamin Herrenschmidt wrote:
> On Tue, 2016-01-12 at 23:52 +0100, Arnd Bergmann wrote:
>> On Tuesday 12 January 2016 15:13:35 liviu.dudau at arm.com wrote:
>>>> int of_address_to_resource(struct device_node *dev, int index,
>>>>                            struct resource *r)
>>>> {
>>>>         ...
>>>>         /* flags can be get here, without ranges property reqired.
>>>>          * if the reg = <0x0 0xe4 4>, I can get flag of
>> IORESOURCE_MEM,
>>>>          * if the reg = <0x1 0xe4 4>, I can get flag of
>> IORESOURCE_IO,
>>>
>>> That is strange, the parent node has #address-cells = <2> so the
>> first two numbers should be part
>>> of the address and not influence the flags. Can you add some
>> debugging in of_get_address() and
>>> try to figure out what bus is used in  *flags = bus-
>>> get_flags(prop) ?
>>>
>>>
>>
>> This is the standard ISA binding. The first cell is the address space
>> (IO or MEM), the second cell is the address within that space. This
>> is similar to how PCI works.
>
> Picking up that mid-way, I have LPC busses on power and am using a
> similar binding. I'll try to grab some examples and review the
> document tomorrow (only just noticed it while unpiling emails post-
> vacation).

Hi Ben,
Thanks for reviewing this, I found a similar implementation at arch/powerpc/
platform/powernv/opal-lpc.c and I had get some ideas from your work. It is
nice to me. I'm expecting your suggestion.Thanks in advance.

>
> Cheers,
> Ben.
>
Regards,
Rongrong
