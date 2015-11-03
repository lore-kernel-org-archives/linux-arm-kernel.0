From: caesar.upstream@gmail.com (Caesar Wang)
Date: Tue, 3 Nov 2015 10:00:39 +0800
Subject: [PATCH v2 1/4] clocksource: rockchip: Make the driver more
 compatible
In-Reply-To: <56379D46.1000402@linaro.org>
References: <1443147298-12603-1-git-send-email-wxt@rock-chips.com>
 <5632E765.4010207@gmail.com> <56334995.6090103@linaro.org>
 <21587719.mnFBFBzBeI@phil> <56379D46.1000402@linaro.org>
Message-ID: <56381547.5070109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,

? 2015?11?03? 01:28, Daniel Lezcano ??:
> On 10/31/2015 12:47 AM, Heiko Stuebner wrote:
>> Hi Daniel,
>>
>> Am Freitag, 30. Oktober 2015, 11:42:29 schrieb Daniel Lezcano:
>>> On 10/30/2015 04:43 AM, Caesar Wang wrote:
>>>> Hi Daniel,
>>>>
>>>> ? 2015?10?01? 03:14, Heiko St?bner ??:
>>>>> Hi Daniel,
>>>>>
>>>>> Am Dienstag, 29. September 2015, 06:18:03 schrieb Daniel Lezcano:
>>>>>> On 09/25/2015 04:14 AM, Caesar Wang wrote:
>>>>>>> Build the arm64 SoCs (e.g.: RK3368) on Rockchip platform,
>>>>>>> There are some failure with build up on timer driver for rockchip.
>>>>>>>
>>>>>>> Says:
>>>>>>> /tmp/ccdAnNy5.s:47: Error: missing immediate expression at  operand
>>>>>>> 1 --
>>>>>>> `dsb`
>>>>>>> ...
>>>>>>>
>>>>>>> The problem was different semantics of dsb on btw arm32 and arm64,
>>>>>>> Here we can convert the dsb with insteading of dsb(sy).The "sy" 
>>>>>>> param
>>>>>>> is the default which you are allow to omit, so on arm32 dsb()and
>>>>>>> dsb(sy)
>>>>>>> are the same.
>>>>>>>
>>>>>>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>>>>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> as you have "just" Acked these patches, I guess you are expecting 
>>>>> them
>>>>> to go
>>>>> through the same tree as the devicetree changes, right?
>>>>
>>>> I'm wonder if someone will apply this series patchs but the wait.:-)
>>>> In fact, I'm no sure that the Acked is really meaning.:-
>>>
>>> Yes, by acking the patch I say I am ok with it and I agree it can go
>>> through another tree.
>>
>> although I guess the two clocksource changes could very well just go
>> through your tree. dsb() -> dsb(sy) is supposed to be equal and the 
>> second
>> one is just cosmetics.  The Kconfig and dts changes need to wait in 
>> any case
>> for 4.5 ... but I guess that may be true for the clocksource changes 
>> as well?
>
> Heiko, Caesar,
>
> I am wondering if the dsb() is really necessary. Is it possible you 
> test the timer by removing this instruction ? Otherwise I will have to 
> setup my board again and it will take awhile.
>

As the @Arnd suggestion,

That's seem ok for me.
Although the writel_relaxed() and writel() a bit different  with DSB() 
and L2's sync.

Do I need send the patch v3?  I will test that on my board.

I'm no sure that why the clocksource driver didn't use the 
writel_relaxed() to work.
Okay, I think we should according to the suggestion or required.

-- 
Thanks,
Caesar
