From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon, 25 Apr 2016 13:03:17 +0100
Subject: [PATCH 3/5] ARM: dts: introduce MPS2 AN385/AN386
In-Reply-To: <5670114.66Ur0mq4Xc@wuerfel>
References: <1461574157-23580-1-git-send-email-vladimir.murzin@arm.com>
 <571DE21A.5010502@suse.com> <571DEE47.3090208@arm.com>
 <5670114.66Ur0mq4Xc@wuerfel>
Message-ID: <571E0785.1060200@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 12:32, Arnd Bergmann wrote:
> On Monday 25 April 2016 11:15:35 Vladimir Murzin wrote:
>>>> +
>>>> +#include "mps2.dtsi"
>>>> +
>>>> +/ {
>>>> +    model = "ARM MPS2 Application Note 385/386";
>>>> +    compatible = "arm,mps2";
>>>> +
>>>> +    aliases {
>>>> +        serial0 = &uart0;
>>>> +    };
>>>> +
>>>> +    chosen {
>>>> +        bootargs = "rdinit=/sbin/init earlycon";
>>>
>>> The rootfs should be independent from the board.
>>> In my opinion, this type of bootargs should not be part of the DTS.
>>
>> I have no strong opinion on this, but quick grep shows plenty places
>> where the same happens, and even [1] has rootfs specific option as an
>> example. So if there is no strong call to remove rdinit from bootargs,
>> I'd prefer to keep it as it makes testing easier for me.
>>
>> [1] Documentation/devicetree/booting-without-of.txt
>>
> 
> I think "rdinit=/sbin/init" is redundant, that is what we try running
> anyway, so I don't see any downside in removing it.

Fair point.

@Sudeep could you fixup it locally or I need to respin?

Cheers
Vladimir

> 
> 	Arnd
> 
> 
