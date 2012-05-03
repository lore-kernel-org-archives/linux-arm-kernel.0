From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 03 May 2012 17:00:27 -0400
Subject: [PATCHv3 5/5] cpuidle: coupled: add trace events
In-Reply-To: <1335816551-27756-6-git-send-email-ccross@android.com>
References: <1335816551-27756-1-git-send-email-ccross@android.com>
 <1335816551-27756-6-git-send-email-ccross@android.com>
Message-ID: <1336078827.14207.109.camel@gandalf.stny.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-30 at 13:09 -0700, Colin Cross wrote:

> diff --git a/include/trace/events/cpuidle.h b/include/trace/events/cpuidle.h
> new file mode 100644
> index 0000000..9b2cbbb
> --- /dev/null
> +++ b/include/trace/events/cpuidle.h
> @@ -0,0 +1,243 @@
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cpuidle
> +
> +#if !defined(_TRACE_CPUIDLE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_CPUIDLE_H
> +
> +#include <linux/atomic.h>
> +#include <linux/tracepoint.h>
> +
> +extern atomic_t cpuidle_trace_seq;
> +
> +TRACE_EVENT(coupled_enter,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_exit,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_spin,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_unspin,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_safe_enter,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_safe_exit,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_idle_enter,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_idle_exit,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_abort,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_detected_abort,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_poke,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);
> +
> +TRACE_EVENT(coupled_poked,
> +
> +	TP_PROTO(unsigned int cpu),
> +
> +	TP_ARGS(cpu),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned int, cpu)
> +		__field(unsigned int, seq)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cpu = cpu;
> +		__entry->seq = atomic_inc_return(&cpuidle_trace_seq);
> +	),
> +
> +	TP_printk("%u %u", __entry->seq, __entry->cpu)
> +);

Egad! Please use DECLARE_EVENT_CLASS() and DEFINE_EVENT() when adding
events that are basically the same. Every TRACE_EVENT() can bloat the
kernel by 5k, using the DEFINE_EVENT()s keeps each event around just a
few hundred bytes.

See include/trace/events/ext4.h for examples.

-- Steve


> +
> +#endif /* if !defined(_TRACE_CPUIDLE_H) || defined(TRACE_HEADER_MULTI_READ) */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
