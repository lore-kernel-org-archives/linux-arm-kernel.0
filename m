From: vincent.guittot@linaro.org (Vincent Guittot)
Date: Fri, 26 Sep 2014 14:39:41 +0200
Subject: [PATCH v6 5/6] sched: replace capacity_factor by usage
In-Reply-To: <54246ACE.1080502@arm.com>
References: <1411488485-10025-1-git-send-email-vincent.guittot@linaro.org>
 <1411488485-10025-6-git-send-email-vincent.guittot@linaro.org>
 <542303DF.8010606@arm.com>
 <CAKfTPtB3-M+pXaurDeWkWGNJ3_mU-FN+EnshGE-eg_r41Hppag@mail.gmail.com>
 <54246ACE.1080502@arm.com>
Message-ID: <CAKfTPtAHP_U=C4s6MO-zcJkaEwJB_0VuZ=D6JnTYTeEt_EtBXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 September 2014 21:19, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 25/09/14 09:35, Vincent Guittot wrote:

[snip]

>>>
>>> In case sgs->group_type is group_overloaded you could set
>>> sgs->group_out_of_capacity to 1 without calling group_is_overloaded again.
>>
>> I prefer to keep sgs->group_out_of_capacity = group_is_overloaded(sgs,
>> env) and use it in group_classify in case of future changes in the
>> classification order
>
> Ok, but than group_is_overloaded is called twice at the end of
> update_sg_lb_stats with exactly the same result. Looks weird in my traces.

sorry i don't catch your point.
group_is_overloaded() is called once for group_out_of_capacity which
is then used in group_classify so it should be called only once

>
>>
> [...]
>
>
