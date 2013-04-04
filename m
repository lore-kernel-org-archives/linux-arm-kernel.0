From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 4 Apr 2013 17:32:49 +0530
Subject: [PATCH v2 05/18] ARM: OMAP5: PM: Enables ES2 PM mode by default
In-Reply-To: <876203wedp.fsf@linaro.org>
References: <1364205910-32392-1-git-send-email-santosh.shilimkar@ti.com>
 <1364205910-32392-6-git-send-email-santosh.shilimkar@ti.com>
 <876203wedp.fsf@linaro.org>
Message-ID: <515D6BE9.2050009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 April 2013 01:55 AM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> 
>> Enables MPUSS ES2 power management mode using ES2_PM_MODE in
>> AMBA_IF_MODE register.
>>
>> 0x0: ES1 behavior, CPU cores would enter and exit OFF mode together. Broken
> 
> What is broken?
> 
Should have added clarification here. Sorry. Changelog is updated as below

0x0: ES1 behavior, CPU cores would enter and exit OFF mode together.
0x1: ES2 behavior, CPU cores are allowed to enter/exit OFF mode independently.

ES1.0 CPUx OFF mode behavior never worked and after analysis by design team,
it was declared as a broken hardware feature. That lead to addition of
ES2.0 behavior which works.

>> 0x1: ES2 behavior, CPU cores are allowed to enter/exit OFF mode independently.
>>
>> The AMBA_IF_MODE register value is stored on SAR RAM and restored by
>> ROM code.
>>
>> Acked-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---

[..]

>> diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
>> index f8bb3b9..8bcaa8c 100644
>> --- a/arch/arm/mach-omap2/omap-wakeupgen.c
>> +++ b/arch/arm/mach-omap2/omap-wakeupgen.c
>> @@ -42,6 +42,7 @@
>>  #define CPU1_ID			0x1
>>  #define OMAP4_NR_BANKS		4
>>  #define OMAP4_NR_IRQS		128
>> +#define OMAP5_AMBA_IF_PM_MODE	(1 << 5)
> 
> nit: use BIT()
> 
Ok.

Regards,
santosh
