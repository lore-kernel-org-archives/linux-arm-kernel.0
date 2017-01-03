From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 3 Jan 2017 15:22:06 +0100
Subject: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
In-Reply-To: <BN3PR07MB25168573DD82F1681CDC8437C96E0@BN3PR07MB2516.namprd07.prod.outlook.com>
References: <1481720175-12703-1-git-send-email-andrei.pistirica@microchip.com>
 <BN3PR07MB2516815EDE69ACDCE27F81A3C96F0@BN3PR07MB2516.namprd07.prod.outlook.com>
 <20170102113155.GA16373@localhost.localdomain>
 <0717c63b-2e29-9ad1-7f01-39817980933f@atmel.com>
 <20170102161359.GD3609@localhost.localdomain>
 <CAFcVECK1vt7Hu4tgSZ2+kKpMxoT-wpikMDq65HaxRv-EMgobHA@mail.gmail.com>
 <BN3PR07MB25168573DD82F1681CDC8437C96E0@BN3PR07MB2516.namprd07.prod.outlook.com>
Message-ID: <bba29875-cc47-17a6-4104-5e8c46402f7d@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/01/2017 ? 11:47, Rafal Ozieblo a ?crit :
>> From: Harini Katakam [mailto:harinikatakamlinux at gmail.com] 
>> Sent: 3 stycznia 2017 06:06
>> Subject: Re: [RFC PATCH net-next v4 1/2] macb: Add 1588 support in Cadence GEM.
>>
>> Hi Richard,
>>
>> On Mon, Jan 2, 2017 at 9:43 PM, Richard Cochran <richardcochran@gmail.com> wrote:
>>> On Mon, Jan 02, 2017 at 03:47:07PM +0100, Nicolas Ferre wrote:
>>>> Le 02/01/2017 ? 12:31, Richard Cochran a ?crit :
>>>>> This Cadence IP core is a complete disaster.
>>>>
>>>> Well, it evolved and propose several options to different SoC 
>>>> integrators. This is not something unusual...
>>>> I suspect as well that some other network adapters have the same 
>>>> weakness concerning PTP timestamp in single register as the early 
>>>> revisions of this IP.
>>>
>>> It appears that this core can neither latch the time on read or write, 
>>> or even latch time stamps.  I have worked with many different PTP HW 
>>> implementations, even early ones like on the ixp4xx, and it is no 
>>> exaggeration to say that this one is uniquely broken.
>>>
>>>> I suspect that Rafal tend to jump too quickly to the latest IP 
>>>> revisions and add more options to this series: let's not try to pour 
>>>> too much things into this code right now.
>>>
>>> Why can't you check the IP version in the driver?
>>
>> There is an IP revision register but it would be probably be
>> better to rely on "caps" from the compatibility strings - to cover SoC specific
>> implementations. Also, when this extended BD is added (with timestamp),
>> additional words will need to be added statically which will be
>> consistent with Andrei's CONFIG_ checks.
> We can distinguish IP cores with and without PTP support by reading
> Design Configuration Register. But to distinguish IP cores with
> timestamps in buffer descriptors and which support only event
> registers, we can only check IP version by reading the revision ID
> register and base on that.
> I agree with Harini, compatibility strings could be better. But we
> might end up with many different configuration in the future.

Compatibility strings and associated configurations are cheap. It's not
a problem to have many different configurations and clearer for this
particular "composite" feature.

> We could use only descriptor approach but there are many Atmel's
> cores on the market which support only event registers.

Yes and once in silicon, it's hard to modify ;-)

Regards,
-- 
Nicolas Ferre
