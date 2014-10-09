From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 9 Oct 2014 17:18:20 +0200
Subject: [PATCH v7 6/7] sched: replace capacity_factor by usage
In-Reply-To: <CAKfTPtCX687FkGgxLO7spfGvDxhDWeFDERLRZ-NakO2Jrpmnhw@mail.gmail.com>
References: <1412684017-16595-1-git-send-email-vincent.guittot@linaro.org>
 <1412684017-16595-7-git-send-email-vincent.guittot@linaro.org>
 <20141009121643.GQ4750@worktop.programming.kicks-ass.net>
 <CAKfTPtCX687FkGgxLO7spfGvDxhDWeFDERLRZ-NakO2Jrpmnhw@mail.gmail.com>
Message-ID: <20141009151820.GX10832@worktop.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 09, 2014 at 04:18:02PM +0200, Vincent Guittot wrote:
> On 9 October 2014 14:16, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Tue, Oct 07, 2014 at 02:13:36PM +0200, Vincent Guittot wrote:
> >> +static inline bool
> >> +group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
> >>  {
> >> +     if ((sgs->group_capacity * 100) >
> >> +                     (sgs->group_usage * env->sd->imbalance_pct))
> >> +             return true;
> >
> > Why the imb_pct there? We're looking for 100% utilization, not 130 or
> > whatnot, right?
> 
> Having exactly 100% is quite difficult because of various rounding.
> So i have added a margin/threshold to prevent any excessive change of the state.
> I have just to use the same margin/threshold than in other place in
> load balance.
> 

Yet you failed to mention this anywhere. Also does it really matter?
