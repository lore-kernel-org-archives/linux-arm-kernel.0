From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 11 Apr 2014 10:30:14 +0200
Subject: [PATCH V4 10/20] ARM: exynos: cpuidle: Move clock setup to pm.c
In-Reply-To: <5346BA09.9020708@samsung.com>
References: <1397123751-1957-1-git-send-email-daniel.lezcano@linaro.org>
 <1397123751-1957-11-git-send-email-daniel.lezcano@linaro.org>
 <5346A367.2070107@samsung.com> <5346A958.1030302@linaro.org>
 <5346BA09.9020708@samsung.com>
Message-ID: <5347A816.4020609@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 05:34 PM, Tomasz Figa wrote:
> On 10.04.2014 16:23, Daniel Lezcano wrote:
>> On 04/10/2014 03:57 PM, Tomasz Figa wrote:
>>> Hi Daniel,
>>>
>>> On 10.04.2014 11:55, Daniel Lezcano wrote:
>>>> One more step is moving the clock ratio setting at idle time in pm.c
>>>>
>>>> The macro names have been changed to be consistent with the other
>>>> macros
>>>> name in the file.
>>>>
>>>> Note, the clock divider was working only when cpuidle was enabled
>>>> because it
>>>> was in its init routine. With this change, the clock divider is set in
>>>> the pm's
>>>> init routine, so it will also operate when the cpuidle driver is not
>>>> set, which
>>>> is good.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>>>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>>> ---
>>>>   arch/arm/mach-exynos/cpuidle.c  |   54
>>>> ---------------------------------------
>>>>   arch/arm/mach-exynos/pm.c       |   35 +++++++++++++++++++++++++
>>>>   arch/arm/mach-exynos/regs-pmu.h |   19 ++++++++++++++
>>>>   3 files changed, 54 insertions(+), 54 deletions(-)
>>>
>>> Sorry that I didn't mention that before, but now I recall that there was
>>> already a similar patch moving this code to Exynos5250 clock driver,
>>> which is the best place for setup of any CMU registers and a step
>>> towards removing one more static IO mapping.
>>
>> Yes, Bartlomiej mentioned it.
>>
>> Is it possible to merge this mentioned patch or to give a pointer to it
>> so I can integrate it into the patchset ?
>
> http://marc.info/?l=linux-arm-kernel&m=138147021207626&w=2
>
> I wonder if it still applies cleanly, though...

Ok, if I refer to the date, this patch has been lost in the limbus. So I 
can integrate it with my patchset without conflicting with any tree. Right ?

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
