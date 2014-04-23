From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 24 Apr 2014 00:42:11 +0900
Subject: [Patch v2 0/4] add cpuidle support for Exynos5420
In-Reply-To: <4517423.BmCv8cudjC@vostro.rjw.lan>
References: <1398080958-21677-5-git-send-email-chander.kashyap@linaro.org>
 <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org>
 <4517423.BmCv8cudjC@vostro.rjw.lan>
Message-ID: <5357DF53.4010806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/14 19:18, Rafael J. Wysocki wrote:
> On Wednesday, April 23, 2014 02:55:50 PM Chander Kashyap wrote:
>> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.
>>
>> This patchset adds cpuidle support for Exynos5420 SoC based on
>> generic big.little cpuidle driver.
>>
>> Tested on SMDK5420.
>>
>> This patch set depends on:
>> 	1. [PATCH 0/5] MCPM backend for Exynos5420
>> 	   http://www.spinics.net/lists/arm-kernel/msg321666.html
>>
>> 	2. [PATCH v4] arm: exynos: generalize power register address calculation
>> 	   http://www.spinics.net/lists/arm-kernel/msg324024.html
>> 		
>> Changelog is in respective patches.
>> Chander Kashyap (4):
>>    cpuidle: config: Add SOC_EXYNOS5420 entry to select
>>      cpuidle-big-little driver
>>    driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
>>    exynos: cpuidle: do not allow cpuidle registration for Exynos5420
>>    mcpm: exynos: populate suspend and powered_up callbacks
>>
>>   arch/arm/mach-exynos/cpuidle.c       |    3 ++
>>   arch/arm/mach-exynos/mcpm-exynos.c   |   53 ++++++++++++++++++++++++++++++++++
>>   drivers/cpuidle/Kconfig.arm          |    2 +-
>>   drivers/cpuidle/cpuidle-big_little.c |    3 +-
>>   4 files changed, 59 insertions(+), 2 deletions(-)
>
> I'm assuming that the Exynos maintainers will take care of this, correct?
>

Yeah, I will if you have any objection :-)

BTW, I need to look at the dependent patches.

- Kukjin
