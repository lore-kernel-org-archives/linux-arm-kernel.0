From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 5 Jul 2013 17:16:03 +0200
Subject: [RFC PATCH 02/13] misc: atmel_ssc: keep the count of pdev->id
In-Reply-To: <51D24318.40908@atmel.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-3-git-send-email-richard.genoud@gmail.com>
 <51D24318.40908@atmel.com>
Message-ID: <CACQ1gAj9bY9Tw2-Ps7-Bm2-gS0PY=hocRPvXCQhmcQ9-sKg1kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/7/2 Bo Shen <voice.shen@atmel.com>:
> Hi Richard,
>
>
> On 7/1/2013 16:39, Richard Genoud wrote:
>>
>> With device tree, pdev->id is always -1, so we introduce a local
>> counter.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
>> ---
>>   drivers/misc/atmel-ssc.c |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
>> index 3afbd82..d1ec5ab 100644
>> --- a/drivers/misc/atmel-ssc.c
>> +++ b/drivers/misc/atmel-ssc.c
>> @@ -173,6 +173,12 @@ out:
>>         return err;
>>   }
>>
>> +/* counter of ssc devive instances.
>> + * With device tree pdev->id is always -1, so we have to keep the
>> + * count ourselves
>> + */
>> +static int ssc_device_id;
>
>
> Do we really need this? If Yes, would it better to get from device through
> of_alias_get_id?

you're right, it seems that we don't need that anymore.

thanks !

Richard.
