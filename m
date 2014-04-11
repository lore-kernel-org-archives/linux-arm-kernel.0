From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 11 Apr 2014 10:31:05 +0900
Subject: [PATCH 01/27] ARM: EXYNOS: Add Exynos3250 SoC ID
In-Reply-To: <5032959.JQvlxpLHiQ@wuerfel>
References: <1397122124-15690-1-git-send-email-cw00.choi@samsung.com>
 <1397122124-15690-2-git-send-email-cw00.choi@samsung.com>
 <5032959.JQvlxpLHiQ@wuerfel>
Message-ID: <534745D9.30604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/10/2014 06:43 PM, Arnd Bergmann wrote:
> On Thursday 10 April 2014 18:28:18 Chanwoo Choi wrote:
>> This patch add Exynos3250's SoC ID. Exynos 3250 is System-On-Chip(SoC) that
>> is based on the 32-bit RISC processor for Smartphone. Exynos3250 uses Cortex-A7
>> dual cores and has a target speed of 1.0GHz.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig             | 22 ++++++++++++++++++++++
>>  arch/arm/mach-exynos/exynos.c            |  1 +
>>  arch/arm/plat-samsung/include/plat/cpu.h | 10 ++++++++++
>>  3 files changed, 33 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index fc8bf18..6da8a68 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -11,6 +11,17 @@ if ARCH_EXYNOS
>>  
>>  menu "SAMSUNG EXYNOS SoCs Support"
>>  
>> +config ARCH_EXYNOS3
>> +	bool "SAMSUNG EXYNOS3"
>> +	select ARM_AMBA
>> +	select CLKSRC_OF
>> +	select HAVE_ARM_SCU if SMP
>> +	select HAVE_SMP
>> +	select PINCTRL
>> +	select PM_GENERIC_DOMAINS if PM_RUNTIME
>> +	help
>> +	  Samsung EXYNOS3 SoCs based systems
>> +
> 
> Isn't S5PV210 also called an Exynos3 these days? Are we going to get
> any conflicts here when merging that code into Exynos as Tomasz has
> suggested in the past?

I knew. But, S5PV210/S5PC110 has not yet included in Exynos3 category on mainline.
Need opinion of Exynos SoC Maintainer to clear this ambiguous stuff.

Dear Kukjin and Tomasz,
I need your opinion about this patch.

Best Regards,
Chanwoo Choi
