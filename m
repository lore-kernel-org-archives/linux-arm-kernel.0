From: andrey.porodko@gmail.com (Andrey A. Porodko)
Date: Wed, 16 Dec 2009 14:20:27 +0500
Subject: Patch for MSP430 and SOC audio support for Neuros OSD2 platform
	code.
In-Reply-To: <87pr6p2z5z.fsf@deeprootsystems.com>
References: <4B1BC0E7.1010403@chelcom.ru> <4B1E782D.3000102@gmail.com>
	<87pr6p2z5z.fsf@deeprootsystems.com>
Message-ID: <4B28A65B.2070208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman wrote:
> "Andrey A. Porodko" <andrey.porodko@gmail.com> writes:
>
>   
>> Hello,
>>
>> Please, consider this patch for Neuros OSD2 platform code. Particular
>> drivers code have been sent to consideration of respective maintainers.
>>
>> Thank you.
>>
>> P.S. Change log added.
>>
>> -------------------------------------------------------------------------
>> From e5aef120a1a4af6b678b8ffe6d9be1d065cb305e Mon Sep 17 00:00:00 2001
>> From: Andrey Porodko <panda@chelcom.ru>
>> Date: Sat, 5 Dec 2009 15:54:42 +0500
>> Subject: [PATCH] Neuros OSD2 board platform code patch for supporting msp430
>>  microcontroller and sound soc.
>>
>> Initial release. Neuros OSD2 board i2c platform data description for MSP430
>> microprocessor and Audio SOC support. MSP430 firmware perform various operations.
>> Such as IR remote, RTC timer and etc. Audio SOC is very similar to DM6446EVM
>> board, the only difference here is i2c port address.
>>
>> Signed-off-by: Andrey Porodko <panda@chelcom.ru>
>> ---
>>  arch/arm/mach-davinci/board-neuros-osd2.c |    6 ++++++
>>  1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
>> index bd9ca07..28b3d67 100644
>> --- a/arch/arm/mach-davinci/board-neuros-osd2.c
>> +++ b/arch/arm/mach-davinci/board-neuros-osd2.c
>> @@ -202,6 +202,12 @@ static struct davinci_i2c_platform_data ntosd2_i2c_pdata = {
>>  };
>>  
>>  static struct i2c_board_info __initdata ntosd2_i2c_info[] =  {
>> +	{					/* MSP430 interface	*/
>> +		I2C_BOARD_INFO("davinci_msp", NTOSD2_MSP430_I2C_ADDR),
>> +	},
>>     
>
> Until the MSP430 driver is upstream, lets leave this one out.
>   
>> +	{
>> +		I2C_BOARD_INFO("tlv320aic3x", NTOSD2_AUDIOSOC_I2C_ADDR),
>> +	},
>>  };
>>     
>
> Can you resend with just the aic3x addition.
>
> Also, can you update your address book so that my name is not
> associated with the list address: davinci-linux-open-source at linux.davincidsp.com
>
>   
Kevin,

What if we leave it  as it is? My reason is that whoever would want to
implement these drivers will need this modification of platform files.
> I'm not sure if you're trying to send to me and the list but you're
> sending to "Kevin Hilman <davinci-linux-open-source@linux.davincidsp.com>"
> which is not correct.
>   
I'm sorry to hear that. I checked my address lists... Looks like I made
the mess copying and pasting addresses when was sending messages. Well,
I'll be more attentive.




-- 
Best regards
Andrey A. Porodko
 
