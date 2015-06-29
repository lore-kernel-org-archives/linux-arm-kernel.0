From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 29 Jun 2015 11:02:51 +0100
Subject: [PATCH] ARM64: smp: Silence suspicious RCU usage with ipi
 tracepoints
In-Reply-To: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
References: <1435176858-9568-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150629100251.GZ7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 24, 2015 at 01:14:18PM -0700, Stephen Boyd wrote:
> John Stultz reported an RCU splat on ARM with ipi trace events
> enabled. It looks like the same problem exists on ARM64.
> 
> At this point in the IPI handling path we haven't called
> irq_enter() yet, so RCU doesn't know that we're about to exit
> idle and properly warns that we're using RCU from an idle CPU.
> Use trace_ipi_entry_rcuidle() instead of trace_ipi_entry() so
> that RCU is informed about our exit from idle.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
> Fixes: 45ed695ac10a "ARM64: add IPI tracepoints"
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

I can find no trace of your equivalent ARM patch in my mailbox, but my
comment is as relevant to that message as it is to this one.

The Fixes: line has a standard format, which is not the formatting above.
Please see Documentation/SubmittingPatches section 2.  Thanks.

I've fixed it when applying the ARM version of this patch.  However, I'm
left wondering whether the lack of update to change the "Silence" to "Fix"
which I _stumbled_ over later in this thread is laziness on your part -
had it not been for the malformed Fixes: line, I would not have known to
update that.

We all gets lots of email every day, expecting people to remember some
comment in the dim and distant past made to a similar but different patch
is not really on.  Please ensure that you update your patches in future.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
