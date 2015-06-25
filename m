From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 24 Jun 2015 21:01:31 -0400
Subject: [PATCH] ARM64: smp: Silence suspicious RCU usage with ipi
 tracepoints
In-Reply-To: <20150624212930.GC12596@twins.programming.kicks-ass.net>
References: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
 <20150624212930.GC12596@twins.programming.kicks-ass.net>
Message-ID: <20150624210131.384d5505@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jun 2015 23:29:30 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Wed, Jun 24, 2015 at 01:14:18PM -0700, Stephen Boyd wrote:
> > John Stultz reported an RCU splat on ARM with ipi trace events
> > enabled. It looks like the same problem exists on ARM64.
> > 
> > At this point in the IPI handling path we haven't called
> > irq_enter() yet, so RCU doesn't know that we're about to exit
> > idle and properly warns that we're using RCU from an idle CPU.
> > Use trace_ipi_entry_rcuidle() instead of trace_ipi_entry() so
> > that RCU is informed about our exit from idle.
> 
> I have a problem with $subject. It says 'silence', whereas afaict this
> fixes an actual bug, so it should be 'fixes'.

Agreed, otherwise Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
