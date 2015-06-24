From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jun 2015 14:59:30 -0700
Subject: [PATCH] ARM64: smp: Silence suspicious RCU usage with ipi
 tracepoints
In-Reply-To: <20150624212930.GC12596@twins.programming.kicks-ass.net>
References: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
 <20150624212930.GC12596@twins.programming.kicks-ass.net>
Message-ID: <558B2842.2030007@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2015 02:29 PM, Peter Zijlstra wrote:
> On Wed, Jun 24, 2015 at 01:14:18PM -0700, Stephen Boyd wrote:
>> John Stultz reported an RCU splat on ARM with ipi trace events
>> enabled. It looks like the same problem exists on ARM64.
>>
>> At this point in the IPI handling path we haven't called
>> irq_enter() yet, so RCU doesn't know that we're about to exit
>> idle and properly warns that we're using RCU from an idle CPU.
>> Use trace_ipi_entry_rcuidle() instead of trace_ipi_entry() so
>> that RCU is informed about our exit from idle.
> I have a problem with $subject. It says 'silence', whereas afaict this
> fixes an actual bug, so it should be 'fixes'.

Fair enough. I can resend or whoever applies this patch can
s/Silence/Fix/ on the $subject.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
