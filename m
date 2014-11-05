From: koen@dominion.thruhere.net (Koen Kooi)
Date: Wed, 5 Nov 2014 15:55:25 +0100
Subject: [linux-sunxi] [RFC Patch 1/4] mfd: AXP20x: Add power supply
 bindings documentation
In-Reply-To: <20141105144832.GB2989@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home> <20141021101503.GE26842@x1>
 <20141021180916.432f02e1@neptune.home> <20141021191905.GR21108@lukather>
 <20141103210244.1425e0c7@neptune.home> <20141104143117.GC26729@lukather>
 <20141104220827.773c53d0@neptune.home> <20141105144832.GB2989@lukather>
Message-ID: <ACF6E448-6936-4212-AB50-0EC4FEEA8C42@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Op 5 nov. 2014, om 15:48 heeft Maxime Ripard <maxime.ripard@free-electrons.com> het volgende geschreven:
> 
> On Tue, Nov 04, 2014 at 10:08:27PM +0100, Bruno Pr?mont wrote:
>> On Tue, 04 November 2014 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>>> On Mon, Nov 03, 2014 at 09:02:44PM +0100, Bruno Pr?mont wrote: 
>>>> Doing something like this?:
>>>> 
>>>> --- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> +++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
>>>> @@ -126,9 +126,11 @@
>>>>                                interrupt-controller;
>>>>                                #interrupt-cells = <1>;
>>>> 
>>>> -                               backup = <3000000 200>;
>>>> -                               battery.resistance = <100>;
>>>> -                               battery.capacity = <2000>;
>>>> +                               x-powers,backup = <3000000 200>;
>>> 
>>> I don't really remember what was that property used for. Would it make
>>> sense to put it into the battery node?
>> 
>> The backup/rtc battery is completely distinct from main battery.
>> 
>> It's presence is in no way related to that of the main battery,
>> thus I would not put it into the same node.
>> As all the information needed is included in the property I see
>> no reason to move it into a separate node.
> 
> Oh. So it is to model some button battery that might be here to keep
> the RTC state while the board is unpowered?
> 
> How is that related to the PMIC?

Some PMICs can recharge it and detect it it's empty or not.
