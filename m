From: david@lechnology.com (David Lechner)
Date: Fri, 8 Dec 2017 13:11:03 -0600
Subject: [PATCH v1 1/6] ARM: davinci: clean up map_io functions
In-Reply-To: <2f847539-0425-5d26-a48c-537ed32940ca@ti.com>
References: <1512182054-17410-1-git-send-email-david@lechnology.com>
 <1512182054-17410-2-git-send-email-david@lechnology.com>
 <2f847539-0425-5d26-a48c-537ed32940ca@ti.com>
Message-ID: <9d4b58d5-d1da-00ed-f8e1-1f86c3973910@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2017 09:38 AM, Sekhar Nori wrote:
> On Saturday 02 December 2017 08:04 AM, David Lechner wrote:
>>   static int dm355leopard_mmc_get_cd(int module)
>>   {
>>   	if (!gpio_is_valid(leopard_mmc_gpio))
>> @@ -269,7 +264,7 @@ static __init void dm355_leopard_init(void)
>>   
>>   MACHINE_START(DM355_LEOPARD, "DaVinci DM355 leopard")
>>   	.atag_offset  = 0x100,
>> -	.map_io	      = dm355_leopard_map_io,
>> +	.map_io		= dm355_map_io,
>>   	.init_irq     = davinci_irq_init,
>>   	.init_time	= davinci_timer_init,
>>   	.init_machine = dm355_leopard_init,
> 
> It seems like spaces were used in original code for indentation. Can you
> please introduce a patch to fix that first since you are now touching
> this part of the code?

Many of the board files have mixed spaces and tabs here. I went with 
tabs since the newest commits used tabs. But, yes, I can clean this up.
