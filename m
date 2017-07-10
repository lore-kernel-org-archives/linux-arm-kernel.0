From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 10 Jul 2017 10:39:47 +0530
Subject: [PATCH] hwtracing: coresight: constify attribute_group structures.
In-Reply-To: <CANLsYkxrT+d-HLpPAOM_pZVWfDgTU92Q-njo_0e=K-auYL=BYA@mail.gmail.com>
References: <97ff1c3f7145b0e4326fbbb246579cd5382880b3.1499233557.git.arvind.yadav.cs@gmail.com>
 <CANLsYkxrT+d-HLpPAOM_pZVWfDgTU92Q-njo_0e=K-auYL=BYA@mail.gmail.com>
Message-ID: <a735fa1f-a93a-2885-6f7f-ff7568640011@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mathieu,


On Friday 07 July 2017 08:58 PM, Mathieu Poirier wrote:
> On 4 July 2017 at 23:49, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:
>> attribute_groups are not supposed to change at runtime. All functions
>> working with attribute_groups provided by <linux/sysfs.h> work with const
>> attribute_group. So mark the non-const structs as const.
>>
>> File size before:
>>    text     data     bss     dec     hex filename
>>     2573     288     296    3157     c55 coresight-etm-perf.o
>>
>> File size After adding 'const':
>>     text    data     bss     dec     hex filename
>>     2613     224     296    3133     c3d coresight-etm-perf.o
> Hi Arvind,
>
> Did you find this using an automated tool or simply stumbled on it
> while reviewing the code?  In case of the former it is usually a good
> idea to specify which tool was used in the change log.
       Automated tools are not able to caught this kind of error.
       I have fixed same changes in zram ( commit - dfc8ed8d6a).
       Minchan Kim suggested me to change all the places where have not
       used const. It's good idea have a tool which can able to detect these
       kind of error. I will try to create a tool.
>
> Thanks,
> Mathieu
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> index 288a423..e97775d 100644
>> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
>> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
>> @@ -60,7 +60,7 @@ struct etm_event_data {
>>          NULL,
>>   };
>>
>> -static struct attribute_group etm_pmu_format_group = {
>> +static const struct attribute_group etm_pmu_format_group = {
>>          .name   = "format",
>>          .attrs  = etm_config_formats_attr,
>>   };
>> --
>> 1.9.1
>>
Thanks,
~arvind
