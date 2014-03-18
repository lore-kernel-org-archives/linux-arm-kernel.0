From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 18 Mar 2014 12:25:06 +0530
Subject: [RFC v3 0/5] cpufreq:LAB: Support for LAB governor.
In-Reply-To: <20140317163824.3c5480b3@amdc2363>
References: <1367590072-10496-1-git-send-email-jonghwa3.lee@samsung.com>
 <1393928852-22725-1-git-send-email-l.majewski@samsung.com>
 <20140317163824.3c5480b3@amdc2363>
Message-ID: <CAKohpokz9SknhPH_sgGE6Q8DB+QtaJKSwMG4WgfmWet9skMKUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2014 21:08, Lukasz Majewski <l.majewski@samsung.com> wrote:
>> Despite this patch set is working and applicable on top of 3.14-rc5,
>> please regard it solely as a pure RFC.
>>
>> This patch provides support for LAB governor build on top of ondemand.
>> Previous version of LAB can be found here:
>> http://thread.gmane.org/gmane.linux.kernel/1484746/match=cpufreq
>>
>> LAB short reminder:
>>
>> LAB uses information about how many cores are in "idle" state (the
>> core idleness is represented as the value between 0 and 100) and the
>> overall load of the system (from 0 to 100) to decide about frequency
>> to be set. It is extremely useful with SoCs like Exynos4412, which
>> can set only one frequency for all cores.
>>
>> Important design decisions:
>>
>> - Reuse well established ondemand governor's internal code. To do this
>>   I had to expose some previously static internal ondemand code.
>>   This allowed smaller LAB code when compared to previous version.
>>
>> - LAB works on top of ondemand, which means that one via device tree
>>   attributes can specify if and when e.g. BOOST shall be enabled or
>> if any particular frequency shall be imposed. For situation NOT
>> important from the power consumption reduction viewpoint the ondemand
>> is used to set proper frequency.
>>
>> - It is only possible to either compile in or not the LAB into the
>> kernel. There is no "M" option for Kconfig. It is done on purpose,
>> since ondemand itself can be also compiled as a module and then it
>> would be possible to remove ondemand when LAB is working on top of it.
>>
>> - The LAB operation is specified (and thereof extendable) via device
>> tree lab-ctrl-freq attribute defined at /cpus/cpu0.
>>
>>
>> Problems:
>> - How the governor will work for big.LITTLE systems (especially
>> Global Task Scheduling).
>> - Will there be agreement to expose internal ondemand code to be
>> reused for more specialized governors.
>>
>> Test HW:
>>       Exynos4412 - Trats2 board.
>> Above patches were posted on top of Linux 3.14-rc5
>> (SHA1: 3f9590c281c66162bf8ae9b7b2d987f0a89043c6)
>>
>
> Any comments about those patches?

Sorry for being late on reviewing these..

I tried to go through the patches but didn't looked at the minutest
of the details. Its been a long time when you first sent this patchset.
And the memories have corrupted by now :) ..

To get context back, can we discuss again the fundamentals behind
this new governor you are proposing. And then we can discuss about
it again, its pros/cons, etc..

I tried to go to earlier threads but I think we better do it again..

People are reluctant in getting another governor in and want to give
existing governors a try if possible.

So, please explain the basics behind your governor again and then
we can put our arguments again..

--
viresh
