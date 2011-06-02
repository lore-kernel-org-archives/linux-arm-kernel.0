From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Thu, 2 Jun 2011 11:55:17 -0500
Subject: [PATCH] gpio: ep93xx: move driver to drivers/gpio
In-Reply-To: <BANLkTikmXtg6vV53747LCZd_fwkAvA1EBw@mail.gmail.com>
References: <201105311249.30372.hartleys@visionengravers.com>
	<BANLkTimzWyhZ14ieo0SUfsn8SKp9cM_EBw@mail.gmail.com>
	<ADE657CA350FB648AAC2C43247A983F001F381FC4A77@AUSP01VMBX24.collaborationhost.net>
	<BANLkTikp=Pbh+r3od7fKRP4A7wJrC-i25A@mail.gmail.com>
	<20110601082631.GC3660@n2100.arm.linux.org.uk>
	<BANLkTi=0_t6+=8Ww+a+jX4SR5ni9KQnYqA@mail.gmail.com>
	<ADE657CA350FB648AAC2C43247A983F001F381FC4C6F@AUSP01VMBX24.collaborationhost.net>
	<BANLkTikmXtg6vV53747LCZd_fwkAvA1EBw@mail.gmail.com>
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F381FC4FC0@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 01, 2011 7:45 PM, Kyungmin Park wrote:
> On Thu, Jun 2, 2011 at 2:24 AM, H Hartley Sweeten
>> gpio: Samsung: make Kconfig options def_bool
>>
>> The Samsung GPIO drivers are always built-in when the relevant
>> platform is selected. ?Change the Kconfig symbol to def_bool y
>> dependant on the platform.
>>
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>>
>> ---
>>
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 18c0b31..2e3cd11 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -87,32 +87,20 @@ config GPIO_IT8761E
>> ? ? ? ? ?Say yes here to support GPIO functionality of IT8761E super I/O chip.
>>
>> ?config GPIO_EXYNOS4
>> - ? ? ? bool "Samsung Exynos4 GPIO library support"
>> - ? ? ? default y
>> - ? ? ? depends on ARM && CPU_EXYNOS4210
>> - ? ? ? help
>> - ? ? ? ? Say yes here to support Samsung Exynos4 series SoCs GPIO library
>> + ? ? ? def_bool y
>> + ? ? ? depends on CPU_EXYNOS4210
>>
>> ?config GPIO_PLAT_SAMSUNG
>> - ? ? ? bool "Samsung SoCs GPIO library support"
>> - ? ? ? default y
>> - ? ? ? depends on ARM && SAMSUNG_GPIOLIB_4BIT
>> - ? ? ? help
>> - ? ? ? ? Say yes here to support Samsung SoCs GPIO library
>> + ? ? ? def_bool y
>> + ? ? ? depends on SAMSUNG_GPIOLIB_4BIT
>>
>> ?config GPIO_S5PC100
>> - ? ? ? bool "Samsung S5PC100 GPIO library support"
>> - ? ? ? default y
>> - ? ? ? depends on ARM && CPU_S5PC100
>> - ? ? ? help
>> - ? ? ? ? Say yes here to support Samsung S5PC100 SoCs GPIO library
>> + ? ? ? def_bool y
>> + ? ? ? depends on CPU_S5PC100
>>
>> ?config GPIO_S5PV210
>> - ? ? ? bool "Samsung S5PV210/S5PC110 GPIO library support"
>> - ? ? ? default y
>> - ? ? ? depends on ARM && CPU_S5PV210
>> - ? ? ? help
>> - ? ? ? ? Say yes here to support Samsung S5PV210/S5PC110 SoCs GPIO library
>> + ? ? ? def_bool y
>> + ? ? ? depends on CPU_S5PV210
>>
>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

Kyungmin,

Thanks.  I'll repost this as a proper patch in a new email.

Regards,
Hartley
