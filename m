From: voice.shen@atmel.com (Bo Shen)
Date: Fri, 12 Oct 2012 12:57:34 +0800
Subject: [PATCH] i2c: change the id to let the i2c device work
In-Reply-To: <20121012044042.GI11726@opensource.wolfsonmicro.com>
References: <1350009258-10044-1-git-send-email-voice.shen@atmel.com>
 <20121012044042.GI11726@opensource.wolfsonmicro.com>
Message-ID: <5077A33E.4080801@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 10/12/2012 12:40, Mark Brown wrote:
> On Fri, Oct 12, 2012 at 10:34:18AM +0800, Bo Shen wrote:
>> As the old method will use platform device id, change the id to
>> let the i2c device work
>
> What are "the old method" and new method?  You're not explaining why
> this is needed...

Maybe use the 'legacy method' will be better (I am not sure). Now, the 
Linux kernel is transferring to device tree which doesn't use platform 
device id. So, change the id to let the legacy code work.

May you understand.

>
>>   static struct platform_device at91sam9260_twi_device = {
>>   	.name			= "i2c-gpio",
>> -	.id			= -1,
>> +	.id			= 0,
>>   	.dev.platform_data	= &pdata,
>
> This looks like a regression, if there's only one of a given type of
> device in the system it should have no numeric ID in the display name so
> having -1 is appropriate.
>
