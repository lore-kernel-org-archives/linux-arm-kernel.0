From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 14:31:41 +0000
Subject: ARM perf events spin locks
In-Reply-To: <004601cb9096$c3a5d3b0$4af17b10$@deacon@arm.com>
References: <20101130100802.GB4398@pulham.picochip.com>
	<004101cb907b$16f911b0$44eb3510$@deacon@arm.com>
	<20101130105856.GC4398@pulham.picochip.com>
	<004401cb9095$6b1fbcc0$415f3640$@deacon@arm.com>
	<20101130135407.GH4398@pulham.picochip.com>
	<004601cb9096$c3a5d3b0$4af17b10$@deacon@arm.com>
Message-ID: <20101130143141.GA2377@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 30, 2010 at 01:59:10PM -0000, Will Deacon wrote:
> > > Well struct perf_event_ctx has a lock field which is of type raw_spinlock_t.
> > > I *think* this is always held by the core perf code before calling the backend,
> > > however IRQs may still be enabled so we probably do need to change our pmu_lock.
> > >
> > > Is that a sane analysis?
> > That sounds perfectly reasonable to me! We don't hold these locks for any
> > potentially long periods of time so it's probably better to be safe! Do you
> > want me to make this change after perf-split is merged or is that something
> > you're happy to do?
> 
> I don't mind doing it as a separate patch after Russell has pulled my
> perf-split branch.

You mean this?

commit f1690d17d2c7afa2a2079e3c91eb2bca8c1c5ecd
Merge: 612275a 43eab87
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Fri Nov 26 10:26:43 2010 +0000

    Merge branch 'perf-split' of git://linux-arm.org/linux-2.6-wd into devel-stable

Sorry, I didn't push the tree out for a week or so because I was busy with
other things (like the pgtable stuff.)
