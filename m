From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Thu, 29 May 2014 21:51:12 +0200
Subject: [PATCH v2 11/11] sched: replace capacity by activity
In-Reply-To: <20140529135510.GG11074@laptop.programming.kicks-ass.net>
References: <1400860385-14555-1-git-send-email-vincent.guittot@linaro.org>
 <1400860385-14555-12-git-send-email-vincent.guittot@linaro.org>
 <20140529135510.GG11074@laptop.programming.kicks-ass.net>
Message-ID: <CAKfTPtAdUJfXQAEwA+9+rNJrKE-3B9ZOELUxsWfyVXWre0mKjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2014 15:55, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, May 23, 2014 at 05:53:05PM +0200, Vincent Guittot wrote:
>> The scheduler tries to compute how many tasks a group of CPUs can handle by
>> assuming that a task's load is SCHED_LOAD_SCALE and a CPU capacity is
>> SCHED_POWER_SCALE.
>> We can now have a better idea of the utilization of a group fo CPUs thanks to
>> group_actitvity and deduct how many capacity is still available.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>
> Right, so as Preeti already mentioned, this wrecks SMT. It also seems to
> loose the aggressive spread, where we want to run 1 task on each 'core'
> before we start 'balancing'.
>
> So I think we should be able to fix this by setting PREFER_SIBLING on
> the SMT domain, that way we'll get single tasks running on each SMT
> domain before filling them up until capacity.
>
> Now, its been a while since I looked at PREFER_SIBLING, and I've not yet
> looked at what your patch does to it, but it seems to me that that is
> the first direction we should look for an answer to this.

OK, i'm going to look more deeply in PREFER_SIBLING too
