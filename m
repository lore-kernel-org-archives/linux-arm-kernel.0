From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 2 Jan 2013 11:14:05 +0000
Subject: [RFC PATCH 1/5] ARM: remove useless guard in smp.c
In-Reply-To: <50D43399.7010705@ti.com>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
 <50D43399.7010705@ti.com>
Message-ID: <20130102111405.GA25907@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 21, 2012 at 10:02:01AM +0000, Santosh Shilimkar wrote:
> On Tuesday 18 December 2012 05:36 PM, Mark Rutland wrote:
> > Currently we only provide an implementation of smp_timer_broadcast in
> > smp.c if GENERIC_CLOCKEVENTS_BROADCAST is selected. As
> > smp_timer_broadcast is only used in smp.c, smp.c depends on SMP, and
> > GENERIC_CLOCKEVENTS_BROADCAST is selected by SMP, this is unnecessary.
> >
> > This patch removes the redundant guard.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST isn't mandatory to
> have SMP kernel working so the below select in ARM arch
> kconfig not seems to entirely accurate. SMP kernel will
> still boot with !GENERIC_CLOCKEVENTS_BROADCAST.
> 
> select GENERIC_CLOCKEVENTS_BROADCAST if SMP

Agreed, the selection is not entirely accurate. I'd be happy to see it made
more fine-grained (i.e. selected by platforms) instead.

If people want that I'm happy to drop this patch.

> The issue comes only for deeper CPU power C-states.
> Anyway, you patch is correct from the current code point of
> view.
> 
> Regards
> Santosh

Thanks,
Mark.
