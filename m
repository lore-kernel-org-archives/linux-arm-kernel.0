From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 14:21:47 +0900
Subject: [PATCH v3 5/5] ARM: exynos: select POWER_RESET_SYSCON and
 POWER_RESET_SYSCON_POWEROFF
In-Reply-To: <010401d12c17$1e883d10$5b98b730$@samsung.com>
References: <1447996629-18232-1-git-send-email-alim.akhtar@samsung.com>
 <1447996629-18232-6-git-send-email-alim.akhtar@samsung.com>
 <010401d12c17$1e883d10$5b98b730$@samsung.com>
Message-ID: <565E7FEB.3040806@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.12.2015 18:03, Pavel Fedin wrote:
>  Hello!
> 
> Tested it on top of 4.4-rc3.
>  
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 3a10f1a8317a..d279edf9b10d 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -27,6 +27,9 @@ menuconfig ARCH_EXYNOS
>>  	select SRAM
>>  	select THERMAL
>>  	select MFD_SYSCON
>> +	select POWER_RESET
>> +	select POWER_RESET_SYSCON
>> +	select POWER_RESET_SYSCON_POWEROFF
> 
> "select POWER_SUPPLY" is missing here. Without is we get:
> --- cut ---
> warning: (ARCH_HISI && ARCH_INTEGRATOR && ARCH_EXYNOS && ARCH_VEXPRESS && REALVIEW_DT) selects POWER_RESET which has unmet direct
> dependencies (POWER_SUPPLY)
> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
> warning: (ARCH_EXYNOS) selects POWER_RESET_SYSCON_POWEROFF which has unmet direct dependencies (POWER_SUPPLY && POWER_RESET && OF)
> --- cut ---
> 
>>  	help
>>  	  Support for SAMSUNG EXYNOS SoCs (EXYNOS4/5)
> 
>  Otherwise works fine.
> 
>  Tested-by: Pavel Fedin <p.fedin@samsung.com>

Testing was a little bit too late (late not only looking at date of v1
and v2 but even for v3)... I appreciate it but I applied it already and
in fact I sent a pull request with it.

Actually the proper fix I think is to remove the dependency between
POWER_RESET and POWER_SUPPLY.

Best regards,
Krzysztof
