From: will.deacon@arm.com (Will Deacon)
Date: Mon, 16 Aug 2010 12:00:34 +0100
Subject: [PATCH] ARM: perf: reword comments relating to
	perf_event_do_pending
In-Reply-To: <20100816103526.GB2954@pulham.picochip.com>
References: <1281954331-5633-1-git-send-email-will.deacon@arm.com>
	<20100816103526.GB2954@pulham.picochip.com>
Message-ID: <000501cb3d32$40447b00$c0cd7100$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,

> On Mon, Aug 16, 2010 at 11:25:31AM +0100, Will Deacon wrote:
> > This is purely a cosmetic change to the ARM perf backend because the current
> > comments about the relationship between NMIs, interrupt context and
> > perf_event_do_pending are misleading.
> >
> > This patch updates the comments so that they reflect what the code
> > actually does (which is in line with other architectures).
> >
> > Cc: Jamie Iles <jamie.iles@picochip.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> Yep, that makes much more sense!
> 
> Acked-by: Jamie Iles <jamie.iles@picochip.com>

Thanks for that. We could go a step further and remove the call to
perf_event_do_pending entirely because we don't have NMI and therefore
never queue up any pending events. I guess the caveat here is that
we might hit subtle bugs in the future if pending events are used for
things other than NMI (or if somebody crazy decides to use FIQ as a PMU
interrupt).

I'll leave it in for the moment and submit this patch to the system.

Cheers,

Will
