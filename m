From: peterz@infradead.org (Peter Zijlstra)
Date: Tue, 24 May 2011 18:20:27 +0200
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
References: <20110513125452.GD3924@elte.hu> <1305292132.2466.26.camel@twins>
	<20110513131800.GA7883@elte.hu> <1305294935.2466.64.camel@twins>
	<20110513145737.GC32688@elte.hu>
	<1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
Message-ID: <1306254027.18455.47.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-24 at 10:59 -0500, Will Drewry wrote:
>  include/linux/ftrace_event.h  |    4 +-
>  include/linux/perf_event.h    |   10 +++++---
>  kernel/perf_event.c           |   49 +++++++++++++++++++++++++++++++++++++---
>  kernel/seccomp.c              |    8 ++++++
>  kernel/trace/trace_syscalls.c |   27 +++++++++++++++++-----
>  5 files changed, 82 insertions(+), 16 deletions(-) 

I strongly oppose to the perf core being mixed with any sekurity voodoo
(or any other active role for that matter).
