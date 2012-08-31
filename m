From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 31 Aug 2012 18:05:17 +0800
Subject: [PATCH 1/2] ARM: exynos: delete redundant HAVE_SCHED_CLOCK option
 in Kconfig
In-Reply-To: <CAH9JG2W8xZrkmGkVw_JDY3qSsqHnaTi8-BNoW99V3FUyvWBXng@mail.gmail.com>
References: <1346406296-16223-1-git-send-email-Barry.Song@csr.com>
 <CAH9JG2W8xZrkmGkVw_JDY3qSsqHnaTi8-BNoW99V3FUyvWBXng@mail.gmail.com>
Message-ID: <CAGsJ_4xUBDGn1hDdWvUX68MfC98936v-_vLfPrisLNL7RY6nEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/8/31 Kyungmin Park <kmpark@infradead.org>:
> Hi,
>
> then where select it HAVE_SCHED_CLOCK? apart from other exynos board,
> universal have to use another clock.

The old arch/arm/kernel/Makefile:
obj-$(CONFIG_HAVE_SCHED_CLOCK)  += sched_clock.o
has become:
obj-y += sched_clock.o

>
> Thank you,
> Kyungmin Park
>
> On 8/31/12, Barry Song <Barry.Song@csr.com> wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index b5b4c8c..3fd4ab3 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -243,7 +243,6 @@ config MACH_UNIVERSAL_C210
>>       select CPU_EXYNOS4210
>>       select S5P_HRT
>>       select CLKSRC_MMIO
>> -     select HAVE_SCHED_CLOCK
>>       select S5P_GPIO_INT
>>       select S5P_DEV_FIMC0
>>       select S5P_DEV_FIMC1
>> --
>> 1.7.0.4
>>
-barry
