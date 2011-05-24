From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 24 May 2011 16:14:22 -0400
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <20110524200815.GD27634@elte.hu>
References: <1305563026.5456.19.camel@gandalf.stny.rr.com>
	<20110516165249.GB10929@elte.hu>
	<1305565422.5456.21.camel@gandalf.stny.rr.com>
	<20110517124212.GB21441@elte.hu>
	<1305637528.5456.723.camel@gandalf.stny.rr.com>
	<20110517131902.GF21441@elte.hu>
	<BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
	<1305807728.11267.25.camel@gandalf.stny.rr.com>
	<BANLkTiki8aQJbFkKOFC+s6xAEiuVyMM5MQ@mail.gmail.com>
	<BANLkTim9UyYAGhg06vCFLxkYPX18cPymEQ@mail.gmail.com>
	<20110524200815.GD27634@elte.hu>
Message-ID: <1306268062.1465.79.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-05-24 at 22:08 +0200, Ingo Molnar wrote:
> * Will Drewry <wad@chromium.org> wrote:

> But there could be a perf_tp_event_ret() or perf_tp_event_check() entry that 
> code like seccomp which wants to use event results can use.

We should name it something else. The "perf_tp.." is a misnomer as it
has nothing to do with performance monitoring. "dynamic_event_.." maybe,
as it is dynamic to the affect that we can use jump labels to enable or
disable it.

-- Steve
