From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 17 May 2014 08:24:49 +0900
Subject: [PATCH v3] cpufreq: exynos:  Fix the compile error
In-Reply-To: <2553916.Pl2B0tVZGR@vostro.rjw.lan>
References: <000001cf70f0$2e48f930$8adaeb90$@samsung.com>
 <037e01cf70f5$25b374d0$711a5e70$@samsung.com>
 <2553916.Pl2B0tVZGR@vostro.rjw.lan>
Message-ID: <53769E41.5050603@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/14 08:04, Rafael J. Wysocki wrote:
> On Friday, May 16, 2014 07:54:01 PM Kukjin Kim wrote:
>> Jonghwan Choi wrote:
>>>
>>> Commit 7da83a80 ("ARM: EXYNOS: Migrate Exynos specific macros from plat to
>>> mach") which lands in samsung tree causes build breakage
>>> for cpufreq-exynos like following:
>>>
>>> drivers/cpufreq/exynos-cpufreq.c: In function 'exynos_cpufreq_probe':
>>> drivers/cpufreq/exynos-cpufreq.c:166:2: error: implicit declaration of
>>> function 'soc_is_exynos4210'
>>> [-Werror=implicit-function-declaration]
>>> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of
>>> function 'soc_is_exynos4212'
>>> [-Werror=implicit-function-declaration]
>>> drivers/cpufreq/exynos-cpufreq.c:168:2: error: implicit declaration of
>>> function 'soc_is_exynos4412'
>>> [-Werror=implicit-function-declaration]
>>> drivers/cpufreq/exynos-cpufreq.c:170:2: error: implicit declaration of
>>> function 'soc_is_exynos5250'
>>> [-Werror=implicit-function-declaration]
>>> cc1: some warnings being treated as errors
>>> make[2]: *** [drivers/cpufreq/exynos-cpufreq.o] Error 1
>>> make[2]: *** Waiting for unfinished jobs....
>>> drivers/cpufreq/exynos4x12-cpufreq.c: In function 'exynos4x12_set_clkdiv':
>>> drivers/cpufreq/exynos4x12-cpufreq.c:118:2: error: implicit declaration of
>>> function 'soc_is_exynos4212'
>>> [-Werror=implicit-function-declaration]
>>> cc1: some warnings being treated as errors
>>> make[2]: *** [drivers/cpufreq/exynos4x12-cpufreq.o] Error 1
>>> make[1]: *** [drivers/cpufreq] Error 2
>>> This fixes above error with getting SoC information via
>>> of_machine_is_compatible() instead of soc_is_exynosXXXX().
>>>
>>
>> Probably,
>> Suggested-by: Tomasz Figa ?
>>
>>> Signed-off-by: Jonghwan Choi<jhbird.choi@samsung.com>
>>
>> Looks better.
>>
>> Rafael, if you have no objection on this, shall I pick this into samsung
>> tree for 3.16 because of the current build breakage with enabling exynos
>> cpufreq?
>
> Please go ahead.
>
Done.

Thanks,
Kukjin
