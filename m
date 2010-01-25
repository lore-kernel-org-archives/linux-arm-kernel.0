From: opensolarisdev@gmail.com (Vikram Dhillon)
Date: Sun, 24 Jan 2010 21:15:26 -0500
Subject: [PATCH] RFC: make struct platform_driver.id_table const
In-Reply-To: <20100125013421.GL26562@trinity.fluff.org>
References: <1264179837-22999-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100125013421.GL26562@trinity.fluff.org>
Message-ID: <4B5CFEBE.2070906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/24/2010 08:34 PM, Ben Dooks wrote:
> On Fri, Jan 22, 2010 at 06:03:57PM +0100, Uwe Kleine-K?nig wrote:
>    
>> This fixes a warning on several pxa based machines:
>>
>> 	arch/arm/mach-pxa/ssp.c:475: warning: initialization discards qualifiers from pointer target type
>>      
> this looks sane to me.
>
>    
>> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
>> Cc: Eric Miao<eric.miao@marvell.com>
>> Cc: Greg Kroah-Hartman<gregkh@suse.de>
>> ---
>>   drivers/base/platform.c         |    2 +-
>>   include/linux/platform_device.h |    4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
>> index 58efaf2..962246c 100644
>> --- a/drivers/base/platform.c
>> +++ b/drivers/base/platform.c
>> @@ -578,7 +578,7 @@ static int platform_uevent(struct device *dev, struct kobj_uevent_env *env)
>>   }
>>
>>   static const struct platform_device_id *platform_match_id(
>> -			struct platform_device_id *id,
>> +			const struct platform_device_id *id,
>>   			struct platform_device *pdev)
>>   {
>>   	while (id->name[0]) {
>> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
>> index 71ff887..3a6201e 100644
>> --- a/include/linux/platform_device.h
>> +++ b/include/linux/platform_device.h
>> @@ -21,7 +21,7 @@ struct platform_device {
>>   	u32		num_resources;
>>   	struct resource	* resource;
>>
>> -	struct platform_device_id	*id_entry;
>> +	const struct platform_device_id	*id_entry;
>>
>>   	/* arch specific additions */
>>   	struct pdev_archdata	archdata;
>> @@ -62,7 +62,7 @@ struct platform_driver {
>>   	int (*suspend)(struct platform_device *, pm_message_t state);
>>   	int (*resume)(struct platform_device *);
>>   	struct device_driver driver;
>> -	struct platform_device_id *id_table;
>> +	const struct platform_device_id *id_table;
>>   };
>>
>>   extern int platform_driver_register(struct platform_driver *);
>> -- 
>> 1.6.6
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>      
>    
Look alright here too :) so:
Cc: Vikram Dhillon <dhillonv10@gmail.com>

--
Regards,
Vikram
