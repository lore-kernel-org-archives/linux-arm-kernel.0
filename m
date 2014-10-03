From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 3 Oct 2014 16:51:01 +0200
Subject: [PATCH v6 3/6] sched: add utilization_avg_contrib
In-Reply-To: <20141003143634.GL2849@worktop.programming.kicks-ass.net>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-4-git-send-email-vincent.guittot@linaro.org>
 <20141003143634.GL2849@worktop.programming.kicks-ass.net>
Message-ID: <CAKfTPtDvX=JFf6OBBzTVbo6C76p243za+9CkL-ofSOvHQS5-mQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 October 2014 16:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
>> +      * utilization_load_avg is the sum of the average running time of the
>> +      * sched_entities on the rq.
>>        */
>
> So I think there was some talk about a blocked_utilization thingy, which
> would track the avg running time of the tasks currently asleep, right?
>

yes. Do you mean that we should anticipate and rename
utilization_load_avg into utilization_runnable_avg to make space for a
utilization_blocked_avg that could be added in future ?

>> +     unsigned long runnable_load_avg, blocked_load_avg, utilization_load_avg;
>>       atomic64_t decay_counter;
>>       u64 last_decay;
>>       atomic_long_t removed_load;
