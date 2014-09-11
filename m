From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 11 Sep 2014 14:18:47 +0200
Subject: [PATCH v5 09/12] sched: add usage_load_avg
In-Reply-To: <20140911111736.GV3190@worktop.ger.corp.intel.com>
References: <1409051215-16788-1-git-send-email-vincent.guittot@linaro.org>
 <1409051215-16788-10-git-send-email-vincent.guittot@linaro.org>
 <20140911111736.GV3190@worktop.ger.corp.intel.com>
Message-ID: <CAKfTPtB=+Ybjs5iAB=E9fH2TX49gy+GNWjR7AGottnHH6WoaiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 September 2014 13:17, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Aug 26, 2014 at 01:06:52PM +0200, Vincent Guittot wrote:
>> index 5c2c885..7dfd584 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1073,10 +1073,10 @@ struct sched_avg {
>>        * above by 1024/(1-y).  Thus we only need a u32 to store them for all
>>        * choices of y < 1-2^(-32)*1024.
>>        */
>> -     u32 runnable_avg_sum, runnable_avg_period;
>> +     u32 runnable_avg_sum, runnable_avg_period, running_avg_sum;
>
> Seeing how we use runnable_avg_period for both runnable and running,
> does it make sense to remove the runnable part of it from the name?

It's right

>
> Also, 4 byte hole here, not sure we've got anything useful to stuff in
> it though.

I can move all u32 declaration at the end of the struct unless it has
been put before any u64 for good reason

>
>>       u64 last_runnable_update;
>>       s64 decay_count;
>> -     unsigned long load_avg_contrib;
>> +     unsigned long load_avg_contrib, usage_avg_contrib;
>>  };
>>
>
> Man, I should go look at Yuyang's rewrite of this all again. I just
> tried to figure out the decay stuff and my head hurts ;-)
