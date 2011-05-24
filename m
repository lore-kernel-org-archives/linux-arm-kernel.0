From: mingo@elte.hu (Ingo Molnar)
Date: Tue, 24 May 2011 22:10:53 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <20110524195435.GC27634@elte.hu>
References: <1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<1306254027.18455.47.camel@twins> <20110524195435.GC27634@elte.hu>
Message-ID: <20110524201053.GE27634@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
> > >  include/linux/ftrace_event.h  |    4 +-
> > >  include/linux/perf_event.h    |   10 +++++---
> > >  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
> > >  kernel/seccomp.c              |    8 ++++++
> > >  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
> > >  5 files changed, 82 insertions(+), 16 deletions(-) 
> > 
> > I strongly oppose to the perf core being mixed with any sekurity voodoo
> > (or any other active role for that matter).
> 
> I'd object to invisible side-effects as well, and vehemently so. But note how 
> intelligently it's used here: it's explicit in the code, it's used explicitly 
> in kernel/seccomp.c and the event generation place in 
> kernel/trace/trace_syscalls.c.
> 
> So this is a really flexible solution IMO and does not extend events with 
> some invisible 'active' role. It extends the *call site* with an open-coded 
> active role - which active role btw. already pre-existed.

Also see my other mail - i think this seccomp code is too tied in to the perf 
core and ABI - but this is fixable IMO.

The fundamental notion that a generator subsystem of events can use filter 
results as well (such as kernel/trace/trace_syscalls.c.) for its own purposes 
is pretty robust though.

Thanks,

	Ingo
