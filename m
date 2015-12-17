From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Dec 2015 10:08:45 +0000
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify already
 reset timer counter
In-Reply-To: <CAJe_Zher2N-jFOBiA-25u0fQv_mdps+_Y4FoFdjiw9E++87TLg@mail.gmail.com>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>	<5670559A.4050404@linaro.org>	<CABb+yY0_JvVV_HG_iU8KJjmwu-nq_Cu5hJ6HBoKZCrZAdJ=rLQ@mail.gmail.com>	<56710BD6.2090502@linaro.org>
 <CAJe_Zher2N-jFOBiA-25u0fQv_mdps+_Y4FoFdjiw9E++87TLg@mail.gmail.com>
Message-ID: <567289AD.5000209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/12/15 09:37, Jassi Brar wrote:
> On 16 December 2015 at 12:29, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 12/16/2015 05:11 AM, Jassi Brar wrote:
>>>
>>> On Tue, Dec 15, 2015 at 11:32 PM, Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 11/25/2015 06:24 AM, Jassi Brar wrote:
>>>>>
>>>>>
>>>>> The GT counter is common to every core in a cluster. There is a usecase
>>>>> when Linux is spawned by a 'master' firmware/OS running on some core of
>>>>> the same cluster and the GT is used by the both.
>>>>>    Linux, upon boot, resetting the GT counter is obviously fatal to the
>>>>> other OS. So provide a way for DT to tell Linux if it's running in that
>>>>> 'slave' mode and must not reset the counter.
>>>>>
>>>>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>>>>
>>>>
>>>>
>>>> Hmm, I doubt that is a hardware description.
>>>>
>>> Its a regular 2core-1cluster platform. The master RTOS on cpu0
>>> maintains the lifecycle of Linux on cpu1.
>>>
>>> 'No_Counter_Reset' is not a h/w thing, I agree, but I don't know how
>>> to better convey that platform specific constraint.
>>
>>
>> May be with a kernel parameter ?
>>
> The fact, that arch-timer driver does it via DT (see commit
> 65b5732d241b8), changes anything? :)

This is a horrible, platform specific hack. I wish we could have pushed
back on this by forcing people to fix their firmware. Why can't you
simply get the firmware to *remove* the node from your device tree
altogether?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
