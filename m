From: stefan@agner.ch (Stefan Agner)
Date: Fri, 26 Sep 2014 09:24:03 +0200
Subject: [PATCH v2 0/3] ARM: vf610: Fix/add clocksource
In-Reply-To: <54250F35.8060306@linaro.org>
References: <1411575610-20895-1-git-send-email-stefan@agner.ch>
 <54250F35.8060306@linaro.org>
Message-ID: <5f84a10302bfb9bc5fed68e789fd1764@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-09-26 09:01, schrieb Daniel Lezcano:
> On 09/24/2014 06:20 PM, Stefan Agner wrote:
>> This patchset came out of need for a clocksource which supports shutdown.
>> In the first version I proposed to just replace the current clocksource
>> with the ARM Global Timer and even proposed to remove the PIT clocksource
>> driver. But Bill Pringlemeir brought up a reasonable point why we should
>> keep the PIT clocksource.
>>
>> Since we need shutdown support for suspend/resume, I added another patch
>> which fixes shutdown functionality for the PIT driver. Now it's possible
>> to use suspend/resume functionality with each of the two clocksources.
>>
>> Changes in v2:
>> - Added shutdown support for PIT clocksource (and hence clocksource
>>    maintainers as receipient).
>> - Create Kconfig entries which allow to choose between the two
>>    clocksources
>> - Clarified commit message
>> - Renamed device tree node to "timer"
>>
> 
> Hi Stefan,
> 
> I will take the patch 1/3 and let the other patches to be acked-by or
> picked in another tree.
> 
> Thanks
>   -- Daniel

Hi Daniel, 

Great thx. If not already to late, can you drop that superfluous empty
line mentioned by Sergei?

--
Stefan

> 
>> Stefan Agner (3):
>>    clocksource: vf_pit_timer: Support shutdown mode
>>    ARM: dts: vf610: Add ARM Global Timer
>>    ARM: vf610: Add ARM Global Timer clocksource option
>>
>>   arch/arm/boot/dts/vf610.dtsi       |  8 ++++++++
>>   arch/arm/mach-imx/Kconfig          | 19 ++++++++++++++++++-
>>   drivers/clocksource/vf_pit_timer.c |  5 +++++
>>   3 files changed, 31 insertions(+), 1 deletion(-)
>>
