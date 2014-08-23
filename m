From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sat, 23 Aug 2014 02:02:27 +0200
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
In-Reply-To: <7hbnrc6px3.fsf@paris.lan>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>	<53DA8BB9.6020702@samsung.com>
 <53DA8D85.3050106@gmail.com> <7hbnrc6px3.fsf@paris.lan>
Message-ID: <53F7DA13.6090305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Thanks for taking a look at this.

On 23.08.2014 01:54, Kevin Hilman wrote:
> Tomasz Figa <tomasz.figa@gmail.com> writes:
> 
>> Kukjin,
>>
>> On 31.07.2014 20:32, Kukjin Kim wrote:
>>> On 07/30/14 17:07, Thomas Abraham wrote:
>>>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>>>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>>>> which did not have CPUfreq driver support, enable the use of generic
>>>> CPUfreq driver.
>>>>
>>>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
>>>> Cc: Kukjin Kim<kgene.kim@samsung.com>
>>>
>>> Looks good to me,
>>>
>>> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
>>>
>>> BTW, who will handle this series? I hope see this series in 3.17.
>>
>> This series consists mostly of clock changes and it likely depends on
>> patches already in my for-next, so I would be inclined toward taking it
>> through samsung-clk tree. 
> 
> So has this series been picked up anywhere?  I don't see it in your
> samsung-clk tree, nor in Kukjin's for-next.

No, it has not. In general it was already too late in the release cycle
when the last version was posted.

I had a plan to take it through clock tree with Kukjin's and Viresh's
cooperation, but now as you say it...

> 
> Also, I'm curious whether or how this is has been tested on big.LITTLE
> SoCs.  
> 
> I'm trying it on the 5800/Chromebook2 and it's not terribly stable.  I'm
> testing along with CPUidle, so there may be some untested interactions
> there as it seems a bit more stable without CPUidle enabled.
> 
> I'd love to hear from anyone else that's testing CPUidle and CPUfreq
> together big.LITTLE 5420/5800, with or without the switcher.

I'd definitely like to see a clarification on this issues, before this
series hits mainline or at least its parts related to affected SoCs.
Also I'd like to hear some confirmation from Samsung Poland R&D Center
guys (on CC), whether this code works stable on their target boards
(Universal C210, Trats, Trats2).

> 
> Also, the patch below[2] is needed for 5800.
> 
> FWIW, I have a temporary branch[1] based on the v3.17-rc branch of the
> exynos-reference tree where I've added the DT patch needed for CPUidle,
> this series (and it's dependencies) which is what I'm using for testing.

The patch looks fine to me (well, it's trivial :)), thanks.

Best regards,
Tomasz
