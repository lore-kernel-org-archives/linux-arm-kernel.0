From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 29 May 2017 15:07:35 +0200
Subject: [PATCH] reset: hisilicon: Fix hi6220 module license
In-Reply-To: <1496051209.17695.36.camel@pengutronix.de>
References: <20170525092232.27960-1-afaerber@suse.de>
 <1496051209.17695.36.camel@pengutronix.de>
Message-ID: <2b19a44e-67e7-1019-e54a-c543fbeafd93@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Am 29.05.2017 um 11:46 schrieb Philipp Zabel:
> On Thu, 2017-05-25 at 11:22 +0200, Andreas F?rber wrote:
>> The hi6220_reset driver fails to load:
>>
>>   [   10.423640] hi6220_reset: module license 'unspecified' taints kernel.
>>   [   10.423644] Disabling lock debugging due to kernel taint
>>   [   10.423735] hi6220_reset: Unknown symbol regmap_write (err 0)
>>   [   10.423747] hi6220_reset: Unknown symbol devm_kmalloc (err 0)
>>   [   10.423759] hi6220_reset: Unknown symbol syscon_node_to_regmap (err 0)
>>   [   10.423768] hi6220_reset: Unknown symbol reset_controller_register (err 0)
>>   [   10.423784] hi6220_reset: Unknown symbol __platform_driver_register (err 0)
>>
>> Add a MODULE_LICENSE() to fix this.
>>
>> Fixes: 70b3590f639f ("reset: hi6220: fix modular build")
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Chen Feng <puck.chen@hisilicon.com>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  drivers/reset/hisilicon/hi6220_reset.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
>> index 35ce53edabf9..d5e5229308f2 100644
>> --- a/drivers/reset/hisilicon/hi6220_reset.c
>> +++ b/drivers/reset/hisilicon/hi6220_reset.c
>> @@ -155,3 +155,5 @@ static int __init hi6220_reset_init(void)
>>  }
>>  
>>  postcore_initcall(hi6220_reset_init);
>> +
>> +MODULE_LICENSE("GPL v2");
> 
> Thank you, I have the same patch queued already.

Is your tree not integrated into linux-next? If so, please send Stephen
Rothwell an email to have that fixed.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
