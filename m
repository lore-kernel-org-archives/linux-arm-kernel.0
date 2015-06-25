From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Jun 2015 14:24:54 +0100
Subject: [PATCH] ARM64: smp: Silence suspicious RCU usage with ipi
 tracepoints
In-Reply-To: <558B2842.2030007@codeaurora.org>
References: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
 <20150624212930.GC12596@twins.programming.kicks-ass.net>
 <558B2842.2030007@codeaurora.org>
Message-ID: <20150625132453.GA13892@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 02:59:30PM -0700, Stephen Boyd wrote:
> On 06/24/2015 02:29 PM, Peter Zijlstra wrote:
> > On Wed, Jun 24, 2015 at 01:14:18PM -0700, Stephen Boyd wrote:
> >> John Stultz reported an RCU splat on ARM with ipi trace events
> >> enabled. It looks like the same problem exists on ARM64.
> >>
> >> At this point in the IPI handling path we haven't called
> >> irq_enter() yet, so RCU doesn't know that we're about to exit
> >> idle and properly warns that we're using RCU from an idle CPU.
> >> Use trace_ipi_entry_rcuidle() instead of trace_ipi_entry() so
> >> that RCU is informed about our exit from idle.
> > I have a problem with $subject. It says 'silence', whereas afaict this
> > fixes an actual bug, so it should be 'fixes'.
> 
> Fair enough. I can resend or whoever applies this patch can
> s/Silence/Fix/ on the $subject.

I'll apply the patch and change the subject as well.

Thanks.

-- 
Catalin
