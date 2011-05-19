From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 19 May 2011 08:22:08 -0400
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system
	call filtering
In-Reply-To: <BANLkTikBK3-KZ10eErQ6Eex_L6Qe2aZang@mail.gmail.com>
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
Message-ID: <1305807728.11267.25.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-05-18 at 21:07 -0700, Will Drewry wrote:

> Do event_* that return non-void exist in the tree at all now?  I've
> looked at the various tracepoint macros as well as some of the other
> handlers (trace_function, perf_tp_event, etc) and I'm not seeing any
> places where a return value is honored nor could be.  At best, the
> perf_tp_event can be short-circuited it in the hlist_for_each, but
> it'd still need a way to bubble up a failure and result in not calling
> the trace/event that the hook precedes.

No, none of the current trace hooks have return values. That was what I
was talking about how to implement in my previous emails.

-- Steve
