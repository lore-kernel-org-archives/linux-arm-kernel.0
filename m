From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 11 Jan 2010 13:09:05 -0500
Subject: [PATCH] ep93xx: register the pwm devices on the edb93xx dev boards
In-Reply-To: <4B4A7A59.5080600@bluewatersys.com>
References: <201001051508.41896.hartleys@visionengravers.com>
	<4B4A7A59.5080600@bluewatersys.com>
Message-ID: <BD79186B4FD85F4B8E60E381CAEE190902089909@mi8nycmail19.Mi8.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, January 10, 2010 6:10 PM, Ryan Mallon wrote:
> H Hartley Sweeten wrote:
>> ep93xx: register the pwm devices on the edb93xx dev boards
>> 
>> Add the platform init code to register the pwm devices that exist
>> on the various edb93xx development boards.
>> 
>> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
>> Cc: Ryan Mallon <ryan@bluewatersys.com>
>> 
>> ---
>> 
>> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
>> index a4a7be3..cee7e91 100644
>> --- a/arch/arm/mach-ep93xx/edb93xx.c
>> +++ b/arch/arm/mach-ep93xx/edb93xx.c
>> @@ -118,12 +118,33 @@ static void __init edb93xx_register_i2c(void)
>>  	}
>>  }
>>  
>> +
>> +/*************************************************************************
>> + * EDB93xx pwm
>> + *************************************************************************/
>> +static void __init edb93xx_register_pwm(void)
>> +{
>> +	if (machine_is_edb9301() ||
>> +	    machine_is_edb9302() || machine_is_edb9302a()) {
>> +		/* EP9301 and EP9302 only have pwm.1 (EGPIO14) */
>> +		ep93xx_register_pwm(0, 1);
>> +	} if (machine_is_edb9307() || machine_is_edb9307a()) {
>
> else if? Otherwise the else clause below will also occur on 9301, 9302
> and 9302a and try to register the pwm's twice.

Yah, I'm an idiot... Updated patch coming.

Thanks,
Hartley
