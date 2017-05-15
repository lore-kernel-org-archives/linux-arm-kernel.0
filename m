From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 15 May 2017 21:34:33 +0200
Subject: [PATCH 3/3] coresight: etb10: Improve a size determination in
 etb_alloc_buffer()
In-Reply-To: <CANLsYkwxkXZ5t5L1_=2e9FLdkwOg7KUT=u2o-KeEfH8QYOfStA@mail.gmail.com>
References: <5d5cd752-f2f2-b511-6b1e-daf5bf1bc522@users.sourceforge.net>
 <b8ed57f7-cdcf-9b35-4fdd-8833db008ff0@users.sourceforge.net>
 <CANLsYkwxkXZ5t5L1_=2e9FLdkwOg7KUT=u2o-KeEfH8QYOfStA@mail.gmail.com>
Message-ID: <483aafb4-c864-058b-6e61-1189be427d27@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
>> @@ -278,8 +278,7 @@ static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
>>         if (cpu == -1)
>>                 cpu = smp_processor_id();
>>         node = cpu_to_node(cpu);
>> -
>> -       buf = kzalloc_node(sizeof(struct cs_buffers), GFP_KERNEL, node);
>> +       buf = kzalloc_node(sizeof(*buf), GFP_KERNEL, node);
> 
> I'm fine with this change but if it's going to happen, it has to be in
> all the coresight drivers and not just this one - please respin with
> all instances fixed.  One patch per driver would be much appreciated.

Do you imagine that any more modules are affected in a similar way
for this software area?

How do you think about other update suggestions from my selection
which are waiting for a corresponding review?

Regards,
Markus
