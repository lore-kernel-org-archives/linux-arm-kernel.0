From: linux@prisktech.co.nz (Tony Prisk)
Date: Fri, 30 May 2014 08:44:15 +1200
Subject: [PATCH 1/1] ARM: vt8500: Staticize local symbols
In-Reply-To: <4308955.HrfvHXcbAr@wuerfel>
References: <1401191863-9404-1-git-send-email-sachin.kamat@linaro.org>
 <4308955.HrfvHXcbAr@wuerfel>
Message-ID: <53879C1F.1060804@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 28/05/14 00:05, Arnd Bergmann wrote:
> On Tuesday 27 May 2014 17:27:43 Sachin Kamat wrote:
>> Variables local to this file are made static.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>   arch/arm/mach-vt8500/vt8500.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Looks good to me, but you forgot to take the maintainer on Cc.
>
> How should we handle this patch? I guess this is the only one
> for vt8500 in 3.16, so I can pick it up directly with Tony's
> Ack.
>
>> diff --git a/arch/arm/mach-vt8500/vt8500.c b/arch/arm/mach-vt8500/vt8500.c
>> index 4a73464cb11b..2da7be31e7e2 100644
>> --- a/arch/arm/mach-vt8500/vt8500.c
>> +++ b/arch/arm/mach-vt8500/vt8500.c
>> @@ -44,7 +44,7 @@
>>   
>>   static void __iomem *pmc_base;
>>   
>> -void vt8500_restart(enum reboot_mode mode, const char *cmd)
>> +static void vt8500_restart(enum reboot_mode mode, const char *cmd)
>>   {
>>   	if (pmc_base)
>>   		writel(1, pmc_base + VT8500_PMSR_REG);
>> @@ -60,7 +60,7 @@ static struct map_desc vt8500_io_desc[] __initdata = {
>>   	},
>>   };
>>   
>> -void __init vt8500_map_io(void)
>> +static void __init vt8500_map_io(void)
>>   {
>>   	iotable_init(vt8500_io_desc, ARRAY_SIZE(vt8500_io_desc));
>>   }
>> @@ -72,7 +72,7 @@ static void vt8500_power_off(void)
>>   	asm("mcr%? p15, 0, %0, c7, c0, 4" : : "r" (0));
>>   }
>>   
>> -void __init vt8500_init(void)
>> +static void __init vt8500_init(void)
>>   {
>>   	struct device_node *np;
>>   #if defined(CONFIG_FB_VT8500) || defined(CONFIG_FB_WM8505)
>>
Acked-by: Tony Prisk <linux@prisktech.co.nz>

Can you pick this up please Arnd? Doesn't look like there will be 
anything else for 3.16

Regards
Tony P
