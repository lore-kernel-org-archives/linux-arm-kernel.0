From: zourongrong@gmail.com (Rongrong Zou)
Date: Wed, 13 Jan 2016 19:06:42 +0800
Subject: [PATCH v1 3/3] ARM64 LPC: update binding doc
In-Reply-To: <20160113100911.GU13633@e106497-lin.cambridge.arm.com>
References: <1451396032-23708-1-git-send-email-zourongrong@gmail.com>
 <5694C6A4.8060308@huawei.com>
 <20160112101418.GO13633@e106497-lin.cambridge.arm.com>
 <4052627.BRvFkUij6q@wuerfel>
 <20160113100911.GU13633@e106497-lin.cambridge.arm.com>
Message-ID: <56962FC2.1070101@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/1/13 18:09, liviu.dudau at arm.com wrote:
> On Tue, Jan 12, 2016 at 11:54:59PM +0100, Arnd Bergmann wrote:
>> On Tuesday 12 January 2016 10:14:18 liviu.dudau at arm.com wrote:
>>>
>>> OK, looking at of_translate_one() comments it looks like a missing "ranges" property is
>>> only accepted on PowerPC. I suggest you have an empty "ranges" property in your isa
>>> parent node, that will signal to the OF parsing code that the mapping is 1:1. Then have
>>> the IPMI node use the reg = <0x0 0xe4 4>; property values instead of reg = <0x1 0xe4 4>;
>>>
>>>
>>
>> A missing ranges property means that there is no translation, while an
>> empty ranges means a 1:1 translation to the parent bus.
>>
>> We really want the former here, as I/O port addresses are not mapped into
>> the MMIO space of the parent bus.
>
> Agree. However of_translate_one()'s behaviour doesn't match our expectations and I have no
> useful suggestions on what the right behaviour should be.
>

I had tried to modify the drivers/of/address.c to address this problem, but it looks
not so general. I'm not sure you have seen this: https://lkml.org/lkml/2016/1/10/89 .

Regards,
Rongrong
