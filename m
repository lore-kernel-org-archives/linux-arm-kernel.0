From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 19 Jul 2014 04:42:34 +0900
Subject: [PATCH v2] ARM: EXYNOS: Fix build with PM_SLEEP=n
In-Reply-To: <53C66924.3010303@samsung.com>
References: <1405323953-25954-1-git-send-email-k.kozlowski@samsung.com>
 <53C66924.3010303@samsung.com>
Message-ID: <53C978AA.9090603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/16/14 20:59, Tomasz Figa wrote:
> Hi Krzysztof,
>
> On 14.07.2014 09:45, Krzysztof Kozlowski wrote:
>> Fix building of exynos defconfig with disabled PM_SLEEP:
>> CONFIG_PM_SLEEP=n
>> CONFIG_PM_SLEEP_SMP=n
>> CONFIG_SUSPEND=n
>> by moving functions for power up/down of CPU and cluster to platsmp.c
>>
>> The build error messages:
>> arch/arm/mach-exynos/built-in.o: In function `exynos_boot_secondary':
>> arch/arm/mach-exynos/platsmp.c:111: undefined reference to `exynos_cpu_power_state'
>> arch/arm/mach-exynos/platsmp.c:112: undefined reference to `exynos_cpu_power_up'
>> arch/arm/mach-exynos/platsmp.c:116: undefined reference to `exynos_cpu_power_state'
>> make: *** [vmlinux] Error 1
>>
>> Signed-off-by: Krzysztof Kozlowski<k.kozlowski@samsung.com>
>>
>> ---
>> Changes since v1:
>> 1. Use different solution - just move the power up/down functions to a
>>     common place instead of adding stubs in common.h. Suggested by Tomasz
>>     Figa.
>> ---
>>   arch/arm/mach-exynos/platsmp.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>>   arch/arm/mach-exynos/pm.c      | 66 ------------------------------------------
>>   2 files changed, 66 insertions(+), 66 deletions(-)
>>
>
+ Bart,

> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>
Applied, thanks.

Bart, I think this is better at this moment to fix the build breakage 
with disabling PM...if you have any comments, please let me know.

Thanks,
Kukjin
