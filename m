From: andrew@ncrmnt.org (Andrew)
Date: Mon, 13 Apr 2015 17:32:50 +0300
Subject: Fwd: Re: [PATCH 2/2] ARM: mvebu: dts: Add dts file for DLink
 DNS-327L
In-Reply-To: <552BCFAA.2020109@free-electrons.com>
References: <b6534b962d2cf9d21cb72d43f19a6574@mail.ncrmnt.org>
 <552A6209.9040903@gmail.com>
 <cd7445f789f1082f464d464f77807f12@mail.ncrmnt.org>
 <20150412145857.GA14038@lunn.ch>
 <b172d775afa24cea69a9490f531c6b37@mail.ncrmnt.org>
 <20150412194735.GA27921@lunn.ch> <552BCFAA.2020109@free-electrons.com>
Message-ID: <1ec8906f00468ca5a9fa227f8c83fe69@mail.ncrmnt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory CLEMENT ????? 13.04.2015 17:16:
> Hi Andrew(s),
> 
> On 12/04/2015 21:47, Andrew Lunn wrote:
>> On Sun, Apr 12, 2015 at 06:41:31PM +0300, Andrew wrote:
>>> Andrew Lunn ?????????? 12.04.2015 17:58:
>>>>> Okay, got it.
>>>>> I'll file a bug about this issue to the the bugzilla. However
>>>>> something
>>>>> tells me it might not be cpuidle, but D-link. This one's sounds 
>>>>> nasty
>>>>> and it has been around since 3.16.x. How could it go unnoticed?
>>>>> Unfortunately I have no other armada-370 hardware to test it.
>>>> 
>>>> Hi Andrew
>>>> 
>>>> A few of us here do have hardware to test with. Please give a 
>>>> detailed
>>>> description of how you reproduce the issue, and your kernel
>>>> configuration, if different from mvebu_v7_defconfig, or
>>>> multi_v7_defconfig.
>>>> 
>>>> 	Thanks
>>>> 		Andrew
>>> 
>>> 
>>> arch/arm/configs/mvebu_v7_defconfig has 
>>> CONFIG_ARM_MVEBU_V7_CPUIDLE=y,
>>> so it should be sufficient to reproduce the issue. I first 
>>> encountered
>>> this issue using that very config and observed it on 2 DNS-327L boxes 
>>> I
>>> own.
>>> 
>>> All I have to do to trigger the bug - enable cpuidle driver and let
>>> the box
>>> sit for some 4-12 hours, till it hard-freezes. If wdt is enabled -
>>> wdt reboot
>>> will happen.
>> 
>> That simple! Well i've got a 370RD which has been sat mostly idle for
>> weeks, using the mvebu_v7_defconfig, with a few addition things turned
>> on for testing the Ethernet switch on the board. I've not had that
>> lockup.
>> 
>> One thing you can try to narrow it down is the disable the second idle
>> mode. Take a look at armada370_idle_driver. Keep the
>> ARM_CPUIDLE_WFI_STATE but disable the "Deep Idle" state.
> 
> Actually you don't have to modify the kernel you can setup the CPU idle 
> level
> you want at runtime:
> 
> echo 1 > /sys/devices/system/cpu/cpu0/cpuidle/state1/disable
> 
> will disable the state1. By doing this on Armada 370 then you
> will only use the WFI state.
> 
> Do you still have this issue on v4.0-rc7?

Yep, I can confirm having this issue on 4.0-rc7. I will only be able to 
test if
disabling state1 fixes it the next weekend.

> 
> Thanks,
> 
> Gregory
> 
> 
> 
>> 
>>       Andrew
>> 

-- 
Regards,
Andrew
