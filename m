From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 26 Apr 2013 17:40:27 +0200
Subject: [RFC PATCH v4 00/14] sched: packing small tasks
In-Reply-To: <517A969B.5040606@linux.intel.com>
References: <1366910611-20048-1-git-send-email-vincent.guittot@linaro.org>
 <517A969B.5040606@linux.intel.com>
Message-ID: <CAKfTPtCwdw1mYpWRFbPo9zT=9vFANpJyubh1eX-0vJLqrqizgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 April 2013 17:00, Arjan van de Ven <arjan@linux.intel.com> wrote:
> On 4/25/2013 10:23 AM, Vincent Guittot wrote:
>>
>> Hi,
>>
>> This patchset takes advantage of the new per-task load tracking that is
>> available in the kernel for packing the tasks in as few as possible
>> CPU/Cluster/Core. It has got 2 packing modes:
>> -The 1st mode packs the small tasks when the system is not too busy. The
>> main
>> goal is to reduce the power consumption in the low system load use cases
>> by
>> minimizing the number of power domain that are enabled but it also keeps
>> the
>> default behavior which is performance oriented.
>> -The 2nd mode packs all tasks in as few as possible power domains in order
>> to
>> improve the power consumption of the system but at the cost of possible
>> performance decrease because of the increase of the rate of ressources
>> sharing
>> compared to the default mode.
>
>
>
> so I got to ask the hard question; what percentage of system level (not just
> cpu level)
> power consumption gain can you measure (pick your favorite workload)...
>

I haven't system level figures for my patches but only for the cpu
subsystem. If we use the MP3 results in the back of my mail, they show
an improvement of 37 % (113/178) for the CPU subsystem of the
platform. If we assume that the CPU subsystem contributes 25% of an
embedded system power consumption (this can vary across platform
depending of the use of HW accelerator but it should be a almost fair
percentage), the patch can impact the power consumption on up to 9%.

> on x86 (even on the low power stuff) I expect this to be very far into the
> noise
> (since we have per core power gates, and power transitions are pretty fast)
>
> you have some numbers in the back of your mail, but it's hard for me to get
> a conclusion out of
> that (they either measure only cpu power, or are just vague in general)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
