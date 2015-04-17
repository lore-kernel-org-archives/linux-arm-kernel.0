From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 18 Apr 2015 01:00:16 +0900
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: enable UniPhier SoC family
In-Reply-To: <3561768.u8t9ftxvsL@wuerfel>
References: <1429170038-16757-1-git-send-email-yamada.masahiro@socionext.com>
 <1429170038-16757-3-git-send-email-yamada.masahiro@socionext.com>
 <3561768.u8t9ftxvsL@wuerfel>
Message-ID: <CAK7LNAQ7rX7+YQHNmuXvRH7TKcVpNUdDRr5qUS6PYxPa=NYP0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2015-04-16 18:42 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 16 April 2015 16:40:36 Masahiro Yamada wrote:
>> Add UniPhier, a new citizen in the ARM multi platform.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>>  arch/arm/configs/multi_v7_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index d7f038d..24005cf 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -81,6 +81,7 @@ CONFIG_ARCH_TEGRA_3x_SOC=y
>>  CONFIG_ARCH_TEGRA_114_SOC=y
>>  CONFIG_ARCH_TEGRA_124_SOC=y
>>  CONFIG_TEGRA_EMC_SCALING_ENABLE=y
>> +CONFIG_ARCH_UNIPHIER=y
>>  CONFIG_ARCH_U8500=y
>>  CONFIG_MACH_HREFV60=y
>>  CONFIG_MACH_SNOWBALL=y
>>
>
> Any additional device drivers you need?
>

Our drivers are still based-on old kernel version (pre-DT) with local
ugly hacking.
I need more time to re-write them based on the current coding style
(almost from scratch),
so I'd like to do it as a second round.

This series is just mainlining a minimal support with a serial console.
I think it is a good starting point.
The UART device is 16550-compatible, so I do not need any additional driver.



-- 
Best Regards
Masahiro Yamada
