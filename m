From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 28 Feb 2011 11:28:29 +0100
Subject: [PATCH 06/09] ARM: s3c2440: gta02: Remove state_mem constraints
	for the pcf50633 regulators
In-Reply-To: <000401cbd710$6035fab0$20a1f010$%kim@samsung.com>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
	<1297043521-21903-6-git-send-email-lars@metafoo.de>
	<000401cbd710$6035fab0$20a1f010$%kim@samsung.com>
Message-ID: <4D6B78CD.5090602@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28/2011 07:26 AM, Kukjin Kim wrote:
> Lars-Peter Clausen wrote:
>>
>> The pcf50633 regulator driver does not use the state_mem constraints, so
>> there
>> is no use in setting them.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  arch/arm/mach-s3c2440/mach-gta02.c |   15 ---------------
>>  1 files changed, 0 insertions(+), 15 deletions(-)
>>
>> diff --git a/arch/arm/mach-s3c2440/mach-gta02.c
> b/arch/arm/mach-s3c2440/mach-
>> gta02.c
>> index e57c4d8..01e0930 100644
>> --- a/arch/arm/mach-s3c2440/mach-gta02.c
>> +++ b/arch/arm/mach-s3c2440/mach-gta02.c
>> @@ -283,9 +283,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
>>  				.valid_modes_mask = REGULATOR_MODE_NORMAL,
>>  				.always_on = 1,
>>  				.apply_uV = 1,
>> -				.state_mem = {
>> -					.enabled = 1,
>> -				},
>>  			},
>>  		},
>>  		[PCF50633_REGULATOR_DOWN1] = {
>> @@ -304,9 +301,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
>>  				.valid_modes_mask = REGULATOR_MODE_NORMAL,
>>  				.apply_uV = 1,
>>  				.always_on = 1,
>> -				.state_mem = {
>> -					.enabled = 1,
>> -				},
>>  			},
>>  		},
>>  		[PCF50633_REGULATOR_HCLDO] = {
>> @@ -325,9 +319,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
>>  				.valid_modes_mask = REGULATOR_MODE_NORMAL,
>>  				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>>  				.apply_uV = 1,
>> -				.state_mem = {
>> -					.enabled = 0,
>> -				},
>>  			},
>>  		},
>>  		[PCF50633_REGULATOR_LDO2] = {
>> @@ -362,9 +353,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
>>  				.valid_modes_mask = REGULATOR_MODE_NORMAL,
>>  				.valid_ops_mask = REGULATOR_CHANGE_STATUS,
>>  				.apply_uV = 1,
>> -				.state_mem = {
>> -					.enabled = 1,
>> -				},
>>  			},
>>  		},
>>  		[PCF50633_REGULATOR_LDO6] = {
>> @@ -379,9 +367,6 @@ struct pcf50633_platform_data gta02_pcf_pdata = {
>>  				.min_uV = 1800000,
>>  				.max_uV = 1800000,
>>  				.valid_modes_mask = REGULATOR_MODE_NORMAL,
>> -				.state_mem = {
>> -					.enabled = 1,
>> -				},
>>  			},
>>  		},
>>
>> --
> 
> Don't we need regulator_suspend_mem_state_show() on PCF50633?
> 
> 
No. The pcf50633 driver has no set_suspend_enable or set_suspend_disable ops.
So the 'suspend_mem_state' sysfs file does not get registered and that function
is never called.

- Lars
