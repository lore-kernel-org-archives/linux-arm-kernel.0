From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 28 Oct 2014 13:05:04 +0900
Subject: [PATCHv2 1/2] ARM: EXYNOS: Add EXYNOS4415 SoC ID
In-Reply-To: <02b501cff262$127d44b0$3777ce10$@kernel.org>
References: <1414373759-4362-1-git-send-email-cw00.choi@samsung.com>
 <1414373759-4362-2-git-send-email-cw00.choi@samsung.com>
 <02b501cff262$127d44b0$3777ce10$@kernel.org>
Message-ID: <544F15F0.9080102@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Kukjin,

On 10/28/2014 12:48 PM, Kukjin Kim wrote:
> Chanwoo Choi wrote:
>>
>> This patch add Exynos4415's SoC ID.
>>
> Since the CPU ID has been removed as per comments, need to update the commit
> message accordingly.

OK, I'll update it.

> 
>> Exynos4415 is based on the 32-bit RISC
>> processor for Smartphone. Exynos4415 uses Cortex A9 quad-cores and has a target
>> speed of 1.6GHz and provides 8.5GB/s memory bandwidth.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Kconfig  | 5 +++++
>>  arch/arm/mach-exynos/exynos.c | 2 ++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
>> index 46f3c0d..349c867 100644
>> --- a/arch/arm/mach-exynos/Kconfig
>> +++ b/arch/arm/mach-exynos/Kconfig
>> @@ -75,6 +75,11 @@ config SOC_EXYNOS4412
>>  	default y
>>  	depends on ARCH_EXYNOS4
>>
>> +config SOC_EXYNOS4415
>> +	bool "SAMSUNG EXYNOS4415"
>> +	default y
>> +	depends on ARCH_EXYNOS4
>> +
> 
> I think, this is not required more...

But,
The clock driver must need to CONFIG_SOC_EXYNOS4415 configuration
to build it. The clock driver[1] of exynos4415 used CONFIG_SOC_EXYNOS4415 as following diff:
  [1] https://lkml.org/lkml/2014/10/26/159

diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 8909c93..4561297 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -5,6 +5,7 @@
 obj-$(CONFIG_COMMON_CLK)	+= clk.o clk-pll.o clk-cpu.o
 obj-$(CONFIG_SOC_EXYNOS3250)	+= clk-exynos3250.o
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clk-exynos4.o
+obj-$(CONFIG_SOC_EXYNOS4415)	+= clk-exynos4415.o

Best Regards,
Chanwoo Choi
