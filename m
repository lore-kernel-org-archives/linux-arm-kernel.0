From: ta.omasab@gmail.com (Thomas Abraham)
Date: Wed, 21 May 2014 18:02:06 +0530
Subject: [PATCH] cpufreq: exynos: Fix driver compilation with
 ARCH_MULTIPLATFORM
In-Reply-To: <537C9B81.5040301@samsung.com>
References: <537C6350.2010707@gmail.com>
 <1400670752-673-1-git-send-email-t.figa@samsung.com>
 <7243145.22RNvZMdch@wuerfel> <537C9B81.5040301@samsung.com>
Message-ID: <CAJuA9ajHAyB6eLe0nQiNcCAS1ojG7W+FTJ1EH62H3Ch-DP2bcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 21, 2014 at 5:56 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> On 21.05.2014 14:21, Arnd Bergmann wrote:
>> On Wednesday 21 May 2014 13:12:32 Tomasz Figa wrote:
>>> Currently Exynos cpufreq drivers rely on globally mapped clock
>>> controller registers to configure frequency of CPU cores. This is
>>> obviously wrong and will be removed in near future, but to enable
>>> support for multi-platform builds without introducing a regression it
>>> needs to be worked around.
>>>
>>> This patch hacks the code to look for clock controller node in device
>>> tree and map its registers using of_iomap(), instead of relying on
>>> global mapping, so dependencies on platform headers are removed and the
>>> driver can compile again with multiplatform support.
>>>
>>> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
>>> ---
>>>  drivers/cpufreq/Kconfig.arm          |  6 +++---
>>>  drivers/cpufreq/exynos-cpufreq.c     |  2 --
>>>  drivers/cpufreq/exynos-cpufreq.h     | 30 ++++++++++++++----------------
>>>  drivers/cpufreq/exynos4210-cpufreq.c | 31 +++++++++++++++++++++++++------
>>>  drivers/cpufreq/exynos4x12-cpufreq.c | 32 ++++++++++++++++++++++++++------
>>>  drivers/cpufreq/exynos5250-cpufreq.c | 35 +++++++++++++++++++++++++++--------
>>>  6 files changed, 95 insertions(+), 41 deletions(-)
>>
>> Isn't this completely obsoleted by Thomas Abraham's work on cpufreq-cpu0
>> support in Exynos? I thought that was going to make it for 3.16.
>
> That would be the best solution, but we need at least one more version
> of that series and I'm not sure if it isn't already too late to merge it
> for 3.16.

I have addressed most the comments on the v4 patches. I will post v5
of the cpufreq consolidation patches a little later or early tomorrow.

Thanks,
Thomas.

>
> Best regards,
> Tomasz
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
