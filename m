From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 29 Mar 2013 12:23:50 +0100
Subject: [PATCH 4/9] ARM: OMAP4: cpuidle: fix wrong driver initialization
In-Reply-To: <515572C7.1030309@ti.com>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>
 <1364553095-25110-4-git-send-email-daniel.lezcano@linaro.org>
 <51556F1D.5030208@ti.com> <515570DF.5010608@linaro.org>
 <515572C7.1030309@ti.com>
Message-ID: <515579C6.1090602@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 11:53 AM, Santosh Shilimkar wrote:
> On Friday 29 March 2013 04:15 PM, Daniel Lezcano wrote:
>> On 03/29/2013 11:38 AM, Santosh Shilimkar wrote:
>>> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>>>> The driver is initialized several times. This is wrong and if the
>>>> return code of the function was checked, it will return -EINVAL.
>>>>
>>>> Move this initialization out of the loop.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>> Fix for this is already and v2 of the patch is here [1]
>>
>> Ah, ok. Thanks for reviewing the patch.
>>
>> Can we find a solution to have a single entry point to sumbit patches
>> for all the cpuidle drivers ?
>>
>> Otherwise, consolidating them is a pain: a patch for the samsung tree,
>> another one for the at91 tree, etc ... and wait for all the trees to
>> sync before continuing to consolidate the code.
>>
>> Wouldn't be worth to move these drivers under the PM umbrella instead of
>> the SoC specific code ?
>>
>> Any idea to simplify the cpuidle consolidation and maintenance ?
>>
> Fisrtly patches get posted to right mailing list based on where the
> code resides. So one must keep a watch on LAKML for the patches.

Yes, I agree.

The main issue is the multiple tree for the different drivers making
hard to track, modify and improve the drivers in one shot.

It is not the first time, a modification of the cpuidle framework
implied to modify all the drivers.

When Rob introduced the first code consolidation, that took months to
add a simple flag in the drivers because we had to wait for the merge
before the changes in drivers/cpuidle/cpuidle.c were visible.

> Talking specific to OMAP idle code, there is plan to move
> to drivers/idle/* but for that to happen there are some PRM/CM
> dependency for which also driver movement is planned. Once
> that happen, OMAP idle will find its way in drivers/idle/*

That would be *really* great. If we can do that for all the drivers,
that will solve the multi-location / multi-tree problem.

The u8500 driver will be moved soon to this directory also.

I did some modifications around the at91 some months ago to encapsulate
the code more, maybe it could be also a good candidate. Nicolas ?

For OMAP3 that could be a bit more difficult. Who is maintaining the
driver now ?

I Cc'ed the different maintainers for the other boards, may be they can
react ?

Thanks
  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
