From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 08 Jan 2014 09:16:50 +0800
Subject: [PATCH 1/3] ARM: hisi: rename hi3xxx to hisi
In-Reply-To: <8738kzcms0.fsf@linaro.org>
References: <1387507978-4485-1-git-send-email-haojian.zhuang@gmail.com>
 <8738kzcms0.fsf@linaro.org>
Message-ID: <52CCA702.8080206@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/08/2014 08:58 AM, Kevin Hilman wrote:
> Haojian Zhuang <haojian.zhuang@linaro.org> writes:
>
>> Since some new Hisilicon SoCs are not named as hi3xxx, rename mach-hi3xxx
>> to mach-hisi instead. And the pronounciation of "hisi" is similar to the
>> chinese pronounciation of Hisilicon. So Hisilicon guys like this name.
>>
>> ARCH_HI3xxx will be renamed later since other drivers are using it and
>> they are still in linux-next git tree. So rename ARCH_HI3xxx later.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>>   arch/arm/Kconfig                                         | 4 ++--
>>   arch/arm/Makefile                                        | 2 +-
>>   arch/arm/{mach-hi3xxx => mach-hisi}/Kconfig              | 0
>>   arch/arm/{mach-hi3xxx => mach-hisi}/Makefile             | 4 ++--
>>   arch/arm/{mach-hi3xxx => mach-hisi}/core.h               | 0
>>   arch/arm/{mach-hi3xxx/hi3xxx.c => mach-hisi/hisilicon.c} | 2 +-
>>   arch/arm/{mach-hi3xxx => mach-hisi}/hotplug.c            | 0
>>   arch/arm/{mach-hi3xxx => mach-hisi}/platsmp.c            | 0
>>   8 files changed, 6 insertions(+), 6 deletions(-)
>>   rename arch/arm/{mach-hi3xxx => mach-hisi}/Kconfig (100%)
>>   rename arch/arm/{mach-hi3xxx => mach-hisi}/Makefile (51%)
>>   rename arch/arm/{mach-hi3xxx => mach-hisi}/core.h (100%)
>>   rename arch/arm/{mach-hi3xxx/hi3xxx.c => mach-hisi/hisilicon.c} (96%)
>>   rename arch/arm/{mach-hi3xxx => mach-hisi}/hotplug.c (100%)
>>   rename arch/arm/{mach-hi3xxx => mach-hisi}/platsmp.c (100%)
>
> Shouldn't the defconfig be renamed also?
>
> Kevin
>
The main difference is on CONFIG_LPAE. The new SoC is using CONFIG_LPAE.
So I didn't change the hi3xxx_defconfig and I'll append a new defconfig for
the new SoC.

Best Regards
Haojian
