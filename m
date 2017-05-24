From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 May 2017 17:39:49 +0200
Subject: [PATCH] ARM: at91: select CONFIG_ARM_CPU_SUSPEND
In-Reply-To: <20170523125738.aha46bqipdsyvax6@piout.net>
References: <20170518144200.3663617-1-arnd@arndb.de>
 <20170523125738.aha46bqipdsyvax6@piout.net>
Message-ID: <CAK8P3a0ThRc1WQEOarj61Y9WhrNzefURTR9ofFa9RUG9wmf_4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 2:57 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> On 18/05/2017 at 16:41:29 +0200, Arnd Bergmann wrote:
>> The reference to cpu_resume requires the corresponding
>> generic code to be enabled when CONFIG_PM is set:
>>
>> arch/arm/mach-at91/pm.o: In function `sama5d2_pm_init':
>> pm.c:(.init.text+0x5e8): undefined reference to `cpu_resume'
>>
>> Fixes: 24a0f5c539f9 ("ARM: at91: pm: Add sama5d2 backup mode")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm/mach-at91/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
>> index e754efd0016e..af76234d60c8 100644
>> --- a/arch/arm/mach-at91/Kconfig
>> +++ b/arch/arm/mach-at91/Kconfig
>> @@ -1,6 +1,7 @@
>>  menuconfig ARCH_AT91
>>       bool "Atmel SoCs"
>>       depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
>> +     select ARM_CPU_SUSPEND if PM
>
> This does not apply on v4.12-rc1 because the depends are different.

Sent a new version now.

       Arnd
