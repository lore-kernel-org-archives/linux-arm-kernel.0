From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Nov 2015 21:39:54 +0100
Subject: [PATCH] bpf_trace: Make dependent on PERF_EVENTS
In-Reply-To: <20151110152817.144195a0@gandalf.local.home>
References: <20151110152817.144195a0@gandalf.local.home>
Message-ID: <48940555.m1MPQSFTCK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 November 2015 15:28:17 Steven Rostedt wrote:
> Arnd Bergmann reported:
> 
>   In my ARM randconfig tests, I'm getting a build error for
>   newly added code in bpf_perf_event_read and bpf_perf_event_output
>   whenever CONFIG_PERF_EVENTS is disabled:
> 
>   kernel/trace/bpf_trace.c: In function 'bpf_perf_event_read':
>   kernel/trace/bpf_trace.c:203:11: error: 'struct perf_event' has no member named 'oncpu'
>   if (event->oncpu != smp_processor_id() ||
>            ^
>   kernel/trace/bpf_trace.c:204:11: error: 'struct perf_event' has no member named 'pmu'
>         event->pmu->count)
> 
>   This can happen when UPROBE_EVENT is enabled but KPROBE_EVENT
>   is disabled. I'm not sure if that is a configuration we care
>   about, otherwise we could prevent this case from occuring by
>   adding Kconfig dependencies.
> 
> Looking at this further, it's really that UPROBE_EVENT enables PERF_EVENTS.
> By just having BPF_EVENTS depend on PERF_EVENTS, then all is fine.
> 
> Link: http://lkml.kernel.org/r/4525348.Aq9YoXkChv at wuerfel
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> 

Ok, sounds good.

Acked-by: Arnd Bergmann <arnd@arndb.de>
