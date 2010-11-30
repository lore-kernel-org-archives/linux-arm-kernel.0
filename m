From: will.deacon@arm.com (Will Deacon)
Date: Tue, 30 Nov 2010 13:59:10 -0000
Subject: ARM perf events spin locks
In-Reply-To: <20101130135407.GH4398@pulham.picochip.com>
References: <20101130100802.GB4398@pulham.picochip.com>
	<004101cb907b$16f911b0$44eb3510$@deacon@arm.com>
	<20101130105856.GC4398@pulham.picochip.com>
	<004401cb9095$6b1fbcc0$415f3640$@deacon@arm.com>
	<20101130135407.GH4398@pulham.picochip.com>
Message-ID: <004601cb9096$c3a5d3b0$4af17b10$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Well struct perf_event_ctx has a lock field which is of type raw_spinlock_t.
> > I *think* this is always held by the core perf code before calling the backend,
> > however IRQs may still be enabled so we probably do need to change our pmu_lock.
> >
> > Is that a sane analysis?
> That sounds perfectly reasonable to me! We don't hold these locks for any
> potentially long periods of time so it's probably better to be safe! Do you
> want me to make this change after perf-split is merged or is that something
> you're happy to do?

I don't mind doing it as a separate patch after Russell has pulled my
perf-split branch. I don't think it should form part of the pull though
because it's unrelated.

Will
