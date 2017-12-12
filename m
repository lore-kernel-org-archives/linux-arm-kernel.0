From: j-keerthy@ti.com (Keerthy)
Date: Tue, 12 Dec 2017 13:52:19 +0530
Subject: [PATCH v5 1/8] clocksource: dmtimer: Remove all the exports
In-Reply-To: <20171212081923.GA10084@lenoch>
References: <1513059137-21593-1-git-send-email-j-keerthy@ti.com>
 <1513059137-21593-2-git-send-email-j-keerthy@ti.com>
 <20171212071624.GA3453@lenoch> <c6a407a8-41c5-f0fd-931c-a58e7e627c82@ti.com>
 <20171212080134.GA9589@lenoch> <9de9b3dc-09f4-d58b-ba5a-60fcb563c665@ti.com>
 <20171212081923.GA10084@lenoch>
Message-ID: <7c92b0c2-8784-9c14-66b0-a19fe68f08ad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 12 December 2017 01:49 PM, Ladislav Michl wrote:
> On Tue, Dec 12, 2017 at 01:38:04PM +0530, Keerthy wrote:
>> On Tuesday 12 December 2017 01:31 PM, Ladislav Michl wrote:
>>> On Tue, Dec 12, 2017 at 01:01:51PM +0530, Keerthy wrote:
>>>>
>>>>
>>>> On Tuesday 12 December 2017 12:46 PM, Ladislav Michl wrote:
>>>>> Keerthy,
>>>>>
>>>>> On Tue, Dec 12, 2017 at 11:42:10AM +0530, Keerthy wrote:
>>>>>> Remove all the unwanted exports from the driver
>>>>>
>>>>> I'm adding event capture capability to the pwm-omap driver and so far used
>>>>> v4.15-rc3 as codebase.
>>>>>
>>>>> Intended use is an IR receiver; for that I need to measure pulses width and
>>>>> spaces between pulses. So DM timer was setup to generate interupt after
>>>>> both TCAR1 and TCAR2 are filled, values are passed to IR decoder and
>>>>> TCAR_IT_FLAG is cleared.
>>>>>
>>>>> Of course, this is just proof of concept and needs to be polished and
>>>>> generalized, but to make it at least work I need functions you just
>>>>> unexported (plus some new).
>>>>>
>>>>> Question is whenever we need this level of indirection (omap_dm_timer_ops)
>>>>> or plain exports are enough.
>>>>
>>>> The general guidance is not to do plain exports and go via
>>>> omap_dm_timer_ops.
>>>
>>> ...in contrary what other clocksource drivers are doing.
>>>
>>> Now I'm assuming it is okay to extend omap_dm_timer_ops. That would mean
>>> check for ops members to be assigned should be also extended or we should
>>> delete it altogether and assume all members are populated?
>>
>> It should be fine to extend omap_dm_timer_ops. What are the ops missing
>> for your new implementation?
> 
> Read capture registers, configure capture and ack interrupt. Perhaps set_pwm
> could be extended to configure capture as well.
> 
> I'll update my code on top of your changes and we'll see how it would work.

Okay Thanks!

> 
>> Tony,
>>
>> Your thoughts on the above?
>>
>> R
