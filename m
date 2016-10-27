From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 27 Oct 2016 21:27:13 +0200
Subject: [PATCH 7/9] Input: wm97xx: split out touchscreen registering
In-Reply-To: <20161027090233.GF28180@localhost.localdomain> (Charles Keepax's
 message of "Thu, 27 Oct 2016 10:02:33 +0100")
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-8-git-send-email-robert.jarzmik@free.fr>
 <20161027090233.GF28180@localhost.localdomain>
Message-ID: <87r3711tke.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Charles Keepax <ckeepax@opensource.wolfsonmicro.com> writes:
> On Wed, Oct 26, 2016 at 09:41:45PM +0200, Robert Jarzmik wrote:
>> diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
>> index 83cf11312fd9..50a110e2988b 100644
> <snip>
>> +static void wm97xx_remove_battery(struct wm97xx *wm)
>> +{
>> +	platform_device_put(wm->battery_dev);
>> +}
> <snip>
>> @@ -724,10 +757,8 @@ static int wm97xx_remove(struct device *dev)
>>  {
>>  	struct wm97xx *wm = dev_get_drvdata(dev);
>>  
>> -	platform_device_unregister(wm->battery_dev);
>> -	platform_device_unregister(wm->touch_dev);
>> -	input_unregister_device(wm->input_dev);
>> -	kfree(wm);
>> +	wm97xx_remove_battery(wm);
>
> The commit message says this is just shifting code around but the
> platform_device_unregister for the battery_dev seems to have
> turned into a platform_device_put here.
Thanks for spotting that, it's clearly a defect in the patch.
That implies a v2 at least for this one.

Cheers.

-- 
Robert
