From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 16 Jun 2017 17:42:45 +0200
Subject: [PATCH] ARM/hw_breakpoint: Fix possible recursive locking for
 arch_hw_breakpoint_init
In-Reply-To: <20170616082238.15553-1-tony@atomide.com>
References: <20170616082238.15553-1-tony@atomide.com>
Message-ID: <20170616154245.5fry4lclgmp3gfdi@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017-06-16 01:22:38 [-0700], Tony Lindgren wrote:
> Recent change to use cpuhp_setup_state_cpuslocked() with commit
> fe2a5cd8aa03 ("ARM/hw_breakpoint: Use cpuhp_setup_state_cpuslocked()")
> missed to change the related paired cpuhp_remove_state_nocalls_cpuslocked().
> 
> Now if arch_hw_breakpoint_init() fails, we get "WARNING: possible recursive
> locking detected" on the exit path.
> 
> Fixes: fe2a5cd8aa03 ("ARM/hw_breakpoint: Use
> cpuhp_setup_state_cpuslocked()")
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you.

Sebastian
