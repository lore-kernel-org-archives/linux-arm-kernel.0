From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Mon, 6 Oct 2014 10:55:07 +0200
Subject: [PATCH v6 5/6] sched: replace capacity_factor by usage
In-Reply-To: <20141003153826.GM2849@worktop.programming.kicks-ass.net>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-6-git-send-email-vincent.guittot@linaro.org>
 <20141003153826.GM2849@worktop.programming.kicks-ass.net>
Message-ID: <CAKfTPtBrS=xJeDuW9_LjtUxdB0U-9ANnhhF8_u_-nxVDGfdHyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 October 2014 17:38, Peter Zijlstra <peterz@infradead.org> wrote:
> On Tue, Sep 23, 2014 at 06:08:04PM +0200, Vincent Guittot wrote:
>
>> This implementation of utilization_avg_contrib doesn't solve the scaling
>> in-variance problem, so i have to scale the utilization with original
>> capacity of the CPU in order to get the CPU usage and compare it with the
>> capacity. Once the scaling invariance will have been added in
>> utilization_avg_contrib, we will remove the scale of utilization_avg_contrib
>> by cpu_capacity_orig in get_cpu_usage. But the scaling invariance will come
>> in another patchset.
>
> I would have expected this in the previous patch that introduced that
> lot. Including a few words on how/why the cpu_capacity is a 'good'
> approximation etc..

That's fair, i can move the explanation

>
>> Finally, the sched_group->sched_group_capacity->capacity_orig has been removed
>> because it's more used during load balance.
>
> That sentence is a contradiction, I expect there's a negative gone
> missing someplace.

yes the "no" is of "because it is no more used during load balance" is missing
