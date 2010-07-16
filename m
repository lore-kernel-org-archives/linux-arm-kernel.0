From: mcuos.com@gmail.com (Wan ZongShun)
Date: Fri, 16 Jul 2010 13:34:21 +0800
Subject: [PATCH] ARM/nuc900: fix nuc900 touchscreen clk definition bug
In-Reply-To: <201007160709.15385.marek.vasut@gmail.com>
References: <4C3FCBFF.50506@gmail.com>
	<201007160709.15385.marek.vasut@gmail.com>
Message-ID: <AANLkTinEqScq2E0MSRJrUN5fR-1rs8fB9rLgMdhYW9R6@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/16 Marek Vasut <marek.vasut@gmail.com>:
> Dne P? 16. ?ervence 2010 05:03:27 Wan ZongShun napsal(a):
>> This patch is to fix nuc900 touchscreen clk definition bug,the .dev_id's
>> name should be 'nuc900-ts', it should be the same to pdev.name. or else,
>> the touchscreen driver will be not working well due to clock engine
>> disabled.
>>
>> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
>> ---
>> ?arch/arm/mach-w90x900/cpu.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-w90x900/cpu.c b/arch/arm/mach-w90x900/cpu.c
>> index 642207e..83c5632 100644
>> --- a/arch/arm/mach-w90x900/cpu.c
>> +++ b/arch/arm/mach-w90x900/cpu.c
>> @@ -93,7 +93,7 @@ static struct clk_lookup nuc900_clkregs[] = {
>> ? ? ? DEF_CLKLOOK(&clk_kpi, "nuc900-kpi", NULL),
>> ? ? ? DEF_CLKLOOK(&clk_wdt, "nuc900-wdt", NULL),
>> ? ? ? DEF_CLKLOOK(&clk_gdma, "nuc900-gdma", NULL),
>> - ? ? DEF_CLKLOOK(&clk_adc, "nuc900-adc", NULL),
>> + ? ? DEF_CLKLOOK(&clk_adc, "nuc900-ts", NULL),
>> ? ? ? DEF_CLKLOOK(&clk_usi, "nuc900-spi", NULL),
>> ? ? ? DEF_CLKLOOK(&clk_ext, NULL, "ext"),
>> ? ? ? DEF_CLKLOOK(&clk_timer0, NULL, "timer0"),
>
> Hey,
>
> Is that thing really touchscreen or general-purpose analog/digital converter ?
>

Oh, it is general-purpose analog/digital converter controller.
I only use it to implemnt my touchscreen function, Also it can be use
other function.

so, I have to change my touchscreen driver name to nuc900-adc?

Thanks for your Reminder, I appreciate it. :)

> Cheers
>



-- 
*linux-arm-kernel mailing list
mail addr:linux-arm-kernel at lists.infradead.org
you can subscribe by:
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

* linux-arm-NUC900 mailing list
mail addr:NUC900 at googlegroups.com
main web: https://groups.google.com/group/NUC900
you can subscribe it by sending me mail:
mcuos.com at gmail.com
