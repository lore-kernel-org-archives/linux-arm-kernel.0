From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Jul 2010 16:36:22 +0100
Subject: [PATCH] ARM: perf: ensure counter delta is limited to 32-bits
In-Reply-To: <20100702200456.GI2357@wear.picochip.com>
References: <1278074642-3045-1-git-send-email-will.deacon@arm.com>
	<20100702180503.GF2357@wear.picochip.com>
	<004401cb19eb$ecab2840$c60178c0$@deacon@arm.com>
	<20100702184848.GH2357@wear.picochip.com>
	<004501cb19f1$4a9a25a0$dfce70e0$@deacon@arm.com>
	<20100702200456.GI2357@wear.picochip.com>
Message-ID: <004601cb19fc$5378a6a0$fa69f3e0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > diff --git a/arch/arm/kernel/perf_event.c b/arch/arm/kernel/perf_event.c
> > index c457686..de12536 100644
> > --- a/arch/arm/kernel/perf_event.c
> > +++ b/arch/arm/kernel/perf_event.c
> > @@ -201,7 +201,7 @@ armpmu_event_update(struct perf_event *event,
> >  {
> >         int shift = 64 - 32;
> >         s64 prev_raw_count, new_raw_count;
> > -       s64 delta;
> > +       u64 delta;
> >
> >  again:
> >         prev_raw_count = atomic64_read(&hwc->prev_count);
> >
> >
> > What do you think?
> Yes, that looks good to me.
> 
> Acked-by: Jamie Iles <jamie.iles@picochip.com>

Thanks. I'll submit this to the patch system with an updated
description and your ack.

Will
