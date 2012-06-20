From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Wed, 20 Jun 2012 11:19:39 +0200
Subject: [PATCH v2 5/5] sched: cpu_power: enable ARCH_POWER
In-Reply-To: <CAKfTPtAdSMJ1RnDPDYZZ378QW9DUCKLA+oC3TWJD7v5KAkFitA@mail.gmail.com>
References: <1340094536-20873-1-git-send-email-vincent.guittot@linaro.org>
 <1340094536-20873-6-git-send-email-vincent.guittot@linaro.org>
 <20120619090110.GA1692@zhy>
 <CAKfTPtAdSMJ1RnDPDYZZ378QW9DUCKLA+oC3TWJD7v5KAkFitA@mail.gmail.com>
Message-ID: <1340183979.21745.78.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-06-20 at 11:11 +0200, Vincent Guittot wrote:
> On 19 June 2012 11:01, Yong Zhang <yong.zhang0@gmail.com> wrote:
> > On Tue, Jun 19, 2012 at 10:28:56AM +0200, Vincent Guittot wrote:
> >> Heteregeneous ARM platform uses arch_scale_freq_power function
> >> to reflect the relative capacity of each core
> >>
> >> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> >> ---
> >>  kernel/sched/features.h |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> >> index de00a48..d98ae90 100644
> >> --- a/kernel/sched/features.h
> >> +++ b/kernel/sched/features.h
> >> @@ -42,7 +42,7 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
> >>  /*
> >>   * Use arch dependent cpu power functions
> >>   */
> >> -SCHED_FEAT(ARCH_POWER, false)
> >> +SCHED_FEAT(ARCH_POWER, true)
> >
> > Hmmm...seems we can remove this knob completely.
> >
> 
> Peter,
> 
> Do you prefer to keep it or remove it completely ?

I prefer to keep it, the 'we can remove it' is true for all feature
bits, they should never be twiddled in normal circumstances, its a debug
feature. As such it makes sense to allow disabling the arch cpu-power
fiddling.
