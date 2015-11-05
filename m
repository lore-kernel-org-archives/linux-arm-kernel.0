From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 05 Nov 2015 11:01:51 +0530
Subject: [PATCH v3 7/7] drivers: soc: Add support for Exynos PMU driver
In-Reply-To: <56381A66.1010406@samsung.com>
References: <1445864143-25695-1-git-send-email-pankaj.dubey@samsung.com>
 <1445864143-25695-8-git-send-email-pankaj.dubey@samsung.com>
 <56381A66.1010406@samsung.com>
Message-ID: <563AE9C7.4030701@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On Tuesday 03 November 2015 07:52 AM, Krzysztof Kozlowski wrote:
> On 26.10.2015 21:55, Pankaj Dubey wrote:
>> This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
>> to "drivers/soc/samsung". This driver is mainly used for setting misc
>> bits of register from PMU IP of Exynos SoC which will be required to
>> configure before Suspend/Resume. Currently all these settings are done
>> in "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
>> support, there is a need of this PMU driver in driver/* folder.
>>
>> This driver uses existing DT binding information and there should
>> be no functionality change in the supported platforms.
>>
>> Signed-off-by: Amit Daniel Kachhap <amitdanielk@gmail.com>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/Kconfig                                   | 1 +
>>   arch/arm/mach-exynos/Makefile                                  | 4 +---
>>   drivers/soc/samsung/Kconfig                                    | 4 ++++
>>   drivers/soc/samsung/Makefile                                   | 4 ++++
>>   arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c | 0
>>   {arch/arm/mach-exynos => drivers/soc/samsung}/exynos-pmu.h     | 0
>>   {arch/arm/mach-exynos => drivers/soc/samsung}/exynos3250-pmu.c | 0
>>   {arch/arm/mach-exynos => drivers/soc/samsung}/exynos4-pmu.c    | 0
>>   {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5250-pmu.c | 0
>>   {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5420-pmu.c | 0
>>   10 files changed, 10 insertions(+), 3 deletions(-)
>>   rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (100%)
>>   rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos-pmu.h (100%)
>>   rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos3250-pmu.c (100%)
>>   rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos4-pmu.c (100%)
>>   rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5250-pmu.c (100%)
>>   rename {arch/arm/mach-exynos => drivers/soc/samsung}/exynos5420-pmu.c (100%)
>>

>
> 1. Please reorder the exynos_sys_powerdown_conf() to be after the
> statics. I am thinking also about adding EXPORT_SYMBOL... but maybe this
> would be over-thinking.
>

I could not understand your point of reordering, will you please explain 
this.

> 2. I think the proper location of everything is drivers/power/reset/.
> Although I don't have strong opinion.
>

There has been discussion about the proper location for this driver, 
initial attempt was done in "drivers/mfd" folder but then we realized 
that this driver is not exactly fitting in MFD category.
There was suggestion from Catalin Marinas [1], [2] to move it to 
"drivers/power" or a more suitable place other than mfd. As I received 
comments from Bartlomiej [3] and other members also (sorry I could not 
produce all links as it was quite more than a year back), I feel driver 
is very much SoC specific and hence decided to move it here.

1: https://lkml.org/lkml/2014/4/28/879
2: 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/252018.html
3: 
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244690.html

> 3. Please cc linux-pm and arm-soc guys (Arnd, Olof, Kevin) on next
> iteration.
>

Ok will keep them in CC in next revision.

Thanks,
Pankaj Dubey

> Best regards,
> Krzysztof
>
