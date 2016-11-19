From: lambert.quentin@gmail.com (Quentin Lambert)
Date: Sat, 19 Nov 2016 19:42:49 +0100
Subject: [PATCH] coresight: perf: Add a missing call to etm_free_aux
In-Reply-To: <3e105f1d-c984-358f-a996-b9d3a2d01e0d@gmail.com>
References: <20161119174124.20136-1-lambert.quentin@gmail.com>
 <3e105f1d-c984-358f-a996-b9d3a2d01e0d@gmail.com>
Message-ID: <0262d841-0dd7-26e5-92d3-52171c0c363b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/19/2016 07:22 PM, Quentin Lambert wrote:
>
> On 11/19/2016 06:41 PM, Quentin Lambert wrote:
>> Most error branches following the call to alloc_event_data contain a 
>> call to
>> etm_free_aux. This patch add a call to etm_free_aux to an error branch
>> that does not call it.
>>
>> This issue was found with Hector.
>>
>> Signed-off-by: Quentin Lambert <lambert.quentin@gmail.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -215,7 +215,7 @@ static void *etm_setup_aux(int event_cpu
>>        */
>>       sink = coresight_get_enabled_sink(true);
>>       if (!sink)
>> -        return NULL;
>> +        goto err;
>>         INIT_WORK(&event_data->work, free_event_data);
> I realized that I hadn't try to compile after having sent this patch and
> I wasn't able to compile it.
> Therefore, please ignore it for now.
I have just confirmed that it compiles.

Quentin
