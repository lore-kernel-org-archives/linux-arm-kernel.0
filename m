From: klightspeed@killerwolves.net (Ben Peddell)
Date: Wed, 19 Feb 2014 23:14:16 +1000
Subject: [PATCH v5 4/5] ARM: Kirkwood: Fix qnap vendor prefix
In-Reply-To: <20140219130553.GO17984@lunn.ch>
References: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
 <1392814154-11284-5-git-send-email-klightspeed@killerwolves.net>
 <20140219130553.GO17984@lunn.ch>
Message-ID: <5304AE28.6030209@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/02/14 23:05, Andrew Lunn wrote:
>> diff --git a/drivers/power/reset/qnap-poweroff.c b/drivers/power/reset/qnap-poweroff.c
>> index a75db7f..d350ece 100644
>> --- a/drivers/power/reset/qnap-poweroff.c
>> +++ b/drivers/power/reset/qnap-poweroff.c
>> @@ -41,7 +41,7 @@ static const struct power_off_cfg synology_power_off_cfg = {
>>  };
>>  
>>  static const struct of_device_id qnap_power_off_of_match_table[] = {
>> -	{ .compatible = "qnap,power-off",
>> +	{ .compatible = "qnapsz,power-off",
>>  	  .data = &qnap_power_off_cfg,
>>  	},
> 
> Hi Ben
> 
> This causes issues for devices using old DT blobs. You need to keep
> the old entry as well as supporting the new vendor prefix.
> 
> We need to consider, is it worth the hassle of changing the prefix,
> since it has been in use for a long time. I think using the stock
> ticker is a "rule of thumb" and not a strict requirement.

So, in this case it would be best to change qnapsz back to qnap in 
patch #1, and completely remove this patch?
