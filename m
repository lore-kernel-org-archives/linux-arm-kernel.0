From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Dec 2012 09:40:19 +0000
Subject: [RFC PATCH 1/5] ARM: remove useless guard in smp.c
In-Reply-To: <50D0BA2D.2020600@codeaurora.org>
References: <1355832418-31692-1-git-send-email-mark.rutland@arm.com>
 <1355832418-31692-2-git-send-email-mark.rutland@arm.com>
 <50D0BA2D.2020600@codeaurora.org>
Message-ID: <20121219094019.GC32484@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 18, 2012 at 06:47:09PM +0000, Stephen Boyd wrote:
> On 12/18/12 04:06, Mark Rutland wrote:
> > Currently we only provide an implementation of smp_timer_broadcast in
> > smp.c if GENERIC_CLOCKEVENTS_BROADCAST is selected. As
> > smp_timer_broadcast is only used in smp.c, smp.c depends on SMP, and
> > GENERIC_CLOCKEVENTS_BROADCAST is selected by SMP, this is unnecessary.
> 
> You might want to add that GENERIC_CLOCKEVENTS_BROADCAST depends on
> GENERIC_CLOCKEVENTS and SMP depends on GENERIC_CLOCKEVENTS too.

Will do.

> > This patch removes the redundant guard.
> >
> > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> 
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks!

Mark.
