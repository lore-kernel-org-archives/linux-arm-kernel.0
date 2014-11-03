From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 3 Nov 2014 17:14:15 +0100
Subject: [PATCH v8 10/10] sched: make scale_rt invariant with frequency
In-Reply-To: <20141103155129.GK12706@worktop.programming.kicks-ass.net>
References: <1414745252-4895-1-git-send-email-vincent.guittot@linaro.org>
 <1414745252-4895-11-git-send-email-vincent.guittot@linaro.org>
 <20141103155129.GK12706@worktop.programming.kicks-ass.net>
Message-ID: <CAKfTPtBQmhv1Lpjsak27m+GW=3tBuskRqv5UiL_cW7rGnVBp9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 November 2014 16:51, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Oct 31, 2014 at 09:47:32AM +0100, Vincent Guittot wrote:
>> The call to arch_scale_frequency_capacity in the rt scheduling path might be
>> a concern for RT folks because I'm not sure whether we can rely on
>> arch_scale_freq_capacity to be short and efficient ?
>
> Well, you put it in quite a hot path on the CFS side too, so it had
> better be blazing fast anyhow.
>
>
> That said, can you move all the running + invariance bits at the
> beginning of the patch set, these appear to be the least controversial
> bits and 'desired' by quite a few people, so we'll try and get those
> agreed upon and merged first.

ok

I'm going to resend with the following order

sched: add utilization_avg_contrib
sched: Track group sched_entity usage contributions
sched: remove frequency scaling from cpu_capacity
sched: Make sched entity usage tracking scale-invariant
sched: make scale_rt invariant with frequency
sched: add per rq cpu_capacity_orig
sched: get CPU's usage statistic
sched: replace capacity_factor by usage
sched: add SD_PREFER_SIBLING for SMT level
sched: move cfs task on a CPU with higher capacity
