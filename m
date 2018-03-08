From: andre.przywara@arm.com (Andre Przywara)
Date: Thu, 8 Mar 2018 15:27:08 +0000
Subject: [linux-sunxi] Re: [PATCH 4/5] dt-bindings: pwm: sunxi: add new
 compatible strings
In-Reply-To: <CAL_Jsq+e8uRm0gi1dn3Ln-b37SC9WGw5aWPaBKoRA2vi-==j6A@mail.gmail.com>
References: <20180307020719.6675-1-andre.przywara@arm.com>
 <20180307020719.6675-5-andre.przywara@arm.com>
 <20180308020822.35utrgw3ksoldr24@rob-hp-laptop>
 <9431a141-8b9c-9743-0907-8f0720df34a2@arm.com>
 <CAL_Jsq+e8uRm0gi1dn3Ln-b37SC9WGw5aWPaBKoRA2vi-==j6A@mail.gmail.com>
Message-ID: <a86bc0b3-8e99-0b0d-2dd5-be42393b0564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/03/18 14:37, Rob Herring wrote:
> On Thu, Mar 8, 2018 at 3:09 AM, Andre Przywara <andre.przywara@arm.com> wrote:
>> Hi,
>>
>> On 08/03/18 02:08, Rob Herring wrote:
>>> On Wed, Mar 07, 2018 at 02:07:18AM +0000, Andre Przywara wrote:
>>>> The PWM controllers found in the Allwinner A64, H5 and H6 SoCs are fully
>>>> compatible to the PWM controllers found in the A13 and H3.
>>>
>>> If fully compatible, then shouldn't there be a fallback to one of the
>>> existing compatible strings?
>>
>> Yes, that was the idea. I was already wondering how we would
>> differentiate that from "real" compatible strings, but couldn't find
>> convincing examples. So should that read:
>>
>> - compatible: should at least contain be one of:
>>     - "allwinner,sun4i-a10-pwm"
>>     - "allwinner,sun5i-a10s-pwm"
>>     - "allwinner,sun5i-a13-pwm"
>>     - "allwinner,sun7i-a20-pwm"
>>     - "allwinner,sun8i-h3-pwm"
>>   May in addition contain one of:
>>     - "allwinner,sun50i-a64-pwm"
>>     - "allwinner,sun50i-h5-pwm"
>>     - "allwinner,sun50i-h6-pwm"
> 
> I can't validate a dts is correct with it written like this. Just list
> each valid combination on each line:
> 
> "allwinner,sun8i-h3-pwm", "allwinner,sun50i-h6-pwm"
> 
> (Assuming "allwinner,sun50i-h6-pwm" was the first implementation and
> h3 has the same block).

Ah, OK, that's makes some sense. I didn't find too many examples outside
of root compatible nodes in the binding docs, but I will use that.

>> And this would possibly need to be amended once we need to actually use
>> one of those strings (to implement a quirk, for instance)?
> 
> The most specific compatible provides that. The driver matches on the
> least specific one until you have a quirk to implement.

Yeah, I was just wondering how a (non-Linux) driver author would induce
what strings are actually needed just by reading the binding. But
enumerating the combinations explicitly should solve this.

Thanks!
Andre.

>> Or is there some other way of reserving those compatible strings, which
>> are not expected to be matched in drivers directly?
> 
> The binding should just list all that are appropriate from the start
> and the driver is free to match on which ever string it wants.
> 
> Rob
> 
