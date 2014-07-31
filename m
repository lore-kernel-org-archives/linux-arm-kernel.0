From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 31 Jul 2014 20:40:05 +0200
Subject: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq driver
 for Exynos4210/5250/5420
In-Reply-To: <53DA8BB9.6020702@samsung.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
 <1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
 <53DA8BB9.6020702@samsung.com>
Message-ID: <53DA8D85.3050106@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin,

On 31.07.2014 20:32, Kukjin Kim wrote:
> On 07/30/14 17:07, Thomas Abraham wrote:
>> The new CPU clock type allows the use of generic CPUfreq drivers. So for
>> Exynos4210/5250, switch to using generic cpufreq driver. For Exynos5420,
>> which did not have CPUfreq driver support, enable the use of generic
>> CPUfreq driver.
>>
>> Suggested-by: Tomasz Figa<t.figa@samsung.com>
>> Cc: Kukjin Kim<kgene.kim@samsung.com>
> 
> Looks good to me,
> 
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> BTW, who will handle this series? I hope see this series in 3.17.

This series consists mostly of clock changes and it likely depends on
patches already in my for-next, so I would be inclined toward taking it
through samsung-clk tree. However, for this I would need Acks for patch
5/6 from Viresh and for patches [1] and [2] (which are dependencies of
this series) from you. I also need to make sure that the two mentioned
patches don't have any dependencies already in your tree.

[1] ARM: dts: add CPU nodes for Exynos4 SoCs
   - https://lkml.org/lkml/2014/7/21/315
[2] ARM: dts: smdk5250: Specify MAX77686 pmic interrupt
   - http://www.spinics.net/lists/arm-kernel/msg351134.html

Best regards,
Tomasz
