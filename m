From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 10 Jul 2014 16:03:51 +0200
Subject: [PATCH v3 08/12] sched: move cfs task on a CPU with higher
 capacity
In-Reply-To: <20140710111833.GY3935@laptop>
References: <1404144343-18720-1-git-send-email-vincent.guittot@linaro.org>
 <1404144343-18720-9-git-send-email-vincent.guittot@linaro.org>
 <20140710111833.GY3935@laptop>
Message-ID: <CAKfTPtD=TiURcppZ+oVUmhMf6Ofxbp4BPA0SCFViu0SDb05oRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2014 13:18, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Jun 30, 2014 at 06:05:39PM +0200, Vincent Guittot wrote:
>> +             /*
>> +              * If the CPUs share their cache and the src_cpu's capacity is
>> +              * reduced because of other sched_class or IRQs, we trig an
>> +              * active balance to move the task
>> +              */
>> +             if ((sd->flags & SD_SHARE_PKG_RESOURCES)
>> +              && ((capacity_orig_of(src_cpu) * 100) > (capacity_of(src_cpu) *
>> +                                                     sd->imbalance_pct)))
>>                       return 1;
>
> Why is this tied to shared caches?

It's just to limit the change of the policy to a level that can have
benefit without performance regression. I'm not sure that we can do
that at any level without risk
