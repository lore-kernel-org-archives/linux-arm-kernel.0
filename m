From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 08 May 2012 11:33:19 +0300
Subject: [PATCH] ARM: OMAP3: cm-t35: add support for power off
In-Reply-To: <4F8FEBBB.70509@compulab.co.il>
References: <1332928278-6582-1-git-send-email-grinberg@compulab.co.il>
 <4F8FEBBB.70509@compulab.co.il>
Message-ID: <4FA8DA4F.6080801@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ping x2

On 04/19/12 13:40, Igor Grinberg wrote:
> ping!
> 
> Tony, can this please, go into 3.5?
> 
> On 03/28/12 11:51, Igor Grinberg wrote:
>> Enable the power off feature of the TPS65930 on-board PMIC.
>>
>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>> ---
>>  arch/arm/mach-omap2/board-cm-t35.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
>> index 8770be1..46275c6 100644
>> --- a/arch/arm/mach-omap2/board-cm-t35.c
>> +++ b/arch/arm/mach-omap2/board-cm-t35.c
>> @@ -499,6 +499,10 @@ static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
>>  	.setup          = cm_t35_twl_gpio_setup,
>>  };
>>  
>> +static struct twl4030_power_data cm_t35_power_data = {
>> +	.use_poweroff	= true,
>> +};
>> +
>>  static struct twl4030_platform_data cm_t35_twldata = {
>>  	/* platform_data for children goes here */
>>  	.keypad		= &cm_t35_kp_data,
>> @@ -506,6 +510,7 @@ static struct twl4030_platform_data cm_t35_twldata = {
>>  	.vmmc1		= &cm_t35_vmmc1,
>>  	.vsim		= &cm_t35_vsim,
>>  	.vio		= &cm_t35_vio,
>> +	.power		= &cm_t35_power_data,
>>  };
>>  
>>  static void __init cm_t35_init_i2c(void)
> 

-- 
Regards,
Igor.
