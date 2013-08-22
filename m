From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 22 Aug 2013 16:01:25 +0800
Subject: [PATCH v2] ARM: OMAP2: use 'int' instead of 'unsigned' for
 variable 'gpmc_irq_start'
In-Reply-To: <20130822075731.GT7656@atomide.com>
References: <521479B4.8030604@asianux.com> <20130822071402.GQ7656@atomide.com>
 <5215C12D.5020807@asianux.com> <5215C209.3080606@asianux.com>
 <20130822075731.GT7656@atomide.com>
Message-ID: <5215C555.9060902@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/22/2013 03:57 PM, Tony Lindgren wrote:
> * Chen Gang <gang.chen@asianux.com> [130822 00:55]:
>> 'gpmc_irq_start' is mostly used as 'int', and for a variable, do not
>> suggest to only use 'unsigned' as its type, so use 'int' instead of
>> 'unsigned' for variable 'gpmc_irq_start'.
>>
>> Also it will fix the related issue (dummy the real world failure):
>>
>>   arch/arm/mach-omap2/gpmc.c:728:2: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
>>
> 
> Thanks applying into omap-for-v3.12/fixes-non-critical.
> 

Thank you too.

Hmm... excuse me, I am not quite familiar with the omap version trees,
so may have a doubt: "it seems this is a real bug, is it suitable to
belong to fixes-none-critical tree ?"


Thanks.

> Tony
>  
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/arm/mach-omap2/gpmc.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index f3fdd6a..9f4795a 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -149,7 +149,7 @@ struct omap3_gpmc_regs {
>>  
>>  static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
>>  static struct irq_chip gpmc_irq_chip;
>> -static unsigned gpmc_irq_start;
>> +static int gpmc_irq_start;
>>  
>>  static struct resource	gpmc_mem_root;
>>  static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
>> -- 
>> 1.7.7.6
> 
> 


-- 
Chen Gang
