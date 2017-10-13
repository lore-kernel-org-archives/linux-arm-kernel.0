From: acme@kernel.org (Arnaldo Carvalho de Melo)
Date: Fri, 13 Oct 2017 10:04:43 -0300
Subject: [PATCH v8 0/4] Add support for ThunderX2 pmu events using json
 files
In-Reply-To: <20171013091141.GA11429@arm.com>
References: <20171012141116.32475-1-ganapatrao.kulkarni@cavium.com>
 <20171012152402.GC5614@arm.com>
 <CAKTKpr6RCzq3QhgptZECZG=YoEmTWCEhM2QaHpzx-ZEtactbHQ@mail.gmail.com>
 <20171013091141.GA11429@arm.com>
Message-ID: <20171013130442.GK3503@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Fri, Oct 13, 2017 at 10:11:42AM +0100, Will Deacon escreveu:
> On Thu, Oct 12, 2017 at 10:54:50PM +0530, Ganapatrao Kulkarni wrote:
> > On Thu, Oct 12, 2017 at 8:54 PM, Will Deacon <will.deacon@arm.com> wrote:
> > > On Thu, Oct 12, 2017 at 07:41:12PM +0530, Ganapatrao Kulkarni wrote:
> > >> Extending json/jevent framework for parsing arm64 event files.
> > >> Adding jevents for ThunderX2 implementation defined PMU events.
> > >>
> > >> v8:
> > >>    - Rename thunderx2 directory to cavium
> > >
> > > For the series:
> > >
> > > Acked-by: Will Deacon <will.deacon@arm.com>
> > 
> > thanks.
> > >
> > > Although note that this conflicts against a queued fix from Mark[1], so
> > > you'll need to rebase on top of that.
> > 
> > sure, will do.
> > may i know the branch/repo which i can rebase to?
> 
> Arnaldo said he was going to apply it to his perf/urgent branch [1],

It is already in tip/perf/urgent, on its way to Linus:

[acme at jouet linux]$ git log -7 --oneline tip/perf/urgent
47a74bdcbfef (HEAD -> perf/urgent, tip/perf/urgent) Merge tag 'perf-urgent-for-mingo-4.14-20171010' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent
629eb703d3e4 perf/x86/intel/uncore: Fix memory leaks on allocation failures
e6a5203399d1 perf/core: Fix cgroup time when scheduling descendants
df0062b27ebf perf/core: Avoid freeing static PMU contexts when PMU is unregistered
aa7b4e02b328 (tag: perf-urgent-for-mingo-4.14-20171010) tools include uapi bpf.h: Sync kernel ABI header with tooling header
66ec11919a0f perf pmu: Unbreak perf record for arm/arm64 with events with explicit PMU
e9516c0813ae (tag: perf-urgent-for-mingo-4.14-20171006, acme/perf/urgent, acme.korg/perf/urgent) perf script: Add missing separator for "-F ip,brstack" (and brstackoff)
[acme at jouet linux]$

> although I can't spot it there yet. I'm also not sure whether that's the
> right thing on which to base 4.15 material. Arnaldo -- what's the best
> thing to do here?

I'll read about the json bits now.
 
> Cheers,
> 
> Will
> 
> [1] http://lkml.kernel.org/r/20171009190000.GL2121 at redhat.com
