From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 May 2015 08:51:05 +0900
Subject: [PATCH] ARM: exynos: Fix wake-up interrupts for Exynos3250
In-Reply-To: <5566E5FC.6020009@arm.com>
References: <1429724452-26563-1-git-send-email-marc.zyngier@arm.com>
 <CAJKOXPd45=c5fybCiyExdyRUZcC9p8zdZqZPPYcjiZd5x28sHw@mail.gmail.com>
 <0d0201d08084$93191f80$b94b5e80$@kernel.org> <5566E5FC.6020009@arm.com>
Message-ID: <5567A9E9.8050004@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.05.2015 18:55, Marc Zyngier wrote:
> On 27/04/15 01:53, Kukjin Kim wrote:
>> Krzysztof Kozlowski wrote:
>>>
>>> 2015-04-23 2:40 GMT+09:00 Marc Zyngier <marc.zyngier@arm.com>:
>>>> Commit 8b283c025443 (ARM: exynos4/5: convert pmu wakeup to
>>>> stacked domains) changed the Exynos PMU code to use stacked
>>>> domains. This has led to a number of interrupt numbers to be
>>>> fixed.
>>>>
>>>> In the meantime, support for Exynos 3250 was added, missing
>>>> the required change to this platform. This amounts to revert
>>>> ace283a04a4a (ARM: EXYNOS: Fix wrong hwirq of RTC interrupt
>>>> for Exynos3250 SoC), as the initial patch was right, just a
>>>> bit early...
>>>>
>>>> Cc: Chanwoo Choi <cw00.choi@samsung.com>
>>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>>> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> Cc: Kukjin Kim <kgene@kernel.org>
>>>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>>>> ---
>>>>  arch/arm/mach-exynos/suspend.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> Acked-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>
>> Thanks and applied.
> 
> Looks like this fix never made it to mainline. What happened?

Indeed, good question - what happened? Anyway I applied this to my tree
so it won't get lost again. I will push it to Kukjin this weekend.

Best regards,
Krzysztof
