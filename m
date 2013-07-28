From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 28 Jul 2013 09:10:09 +0200
Subject: [PATCH] ARM: EXYNOS: cpuidle: Skip C1 cpuidle state for exynos5440
In-Reply-To: <0eaf01ce8863$89d3c4e0$9d7b4ea0$@org>
References: <0e7d01ce8840$82f79070$88e6b150$@org>
 <1374659615-29447-1-git-send-email-amit.daniel@samsung.com>
 <0eaf01ce8863$89d3c4e0$9d7b4ea0$@org>
Message-ID: <51F4C3D1.2060901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 01:47 PM, Kukjin Kim wrote:
> Amit Daniel Kachhap wrote:
>>
>> This patch skips the deep C1(AFTR -Arm off top running) state for
>> exynos5440
>> soc as this soc does not support this state. All the cpu's only allows the
>> basic
>> C0 state.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm/mach-exynos/cpuidle.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/cpuidle.c b/arch/arm/mach-
>> exynos/cpuidle.c
>> index 17a18ff..9a776a1 100644
>> --- a/arch/arm/mach-exynos/cpuidle.c
>> +++ b/arch/arm/mach-exynos/cpuidle.c
>> @@ -210,7 +210,7 @@ static int __init exynos4_init_cpuidle(void)
>>  		device->cpu = cpu_id;
>>
>>  		/* Support IDLE only */
>> -		if (cpu_id != 0)
>> +		if (soc_is_exynos5440() || cpu_id != 0)
>>  			device->state_count = 1;
>>
>>  		ret = cpuidle_register_device(device);
>> --
>> 1.7.1
> 
> Applied, thanks.

You shouldn't have. This patch means exynos5540 has no cpuidle driver at
all. It should be fixed in the Kconfig to unselect CONFIG_CPU_IDLE for
an exynos5540.


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
