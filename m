From: anna-maria@linutronix.de (Anna-Maria Gleixner)
Date: Tue, 5 Apr 2016 11:39:18 +0200 (CEST)
Subject: [PATCH] arm64: hw-breakpoint: Remove superfluous SMP function call
In-Reply-To: <570384DA.6010805@arm.com>
References: <1459766569-17237-1-git-send-email-anna-maria@linutronix.de>
 <570384DA.6010805@arm.com>
Message-ID: <alpine.DEB.2.11.1604051137150.12514@hypnos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Apr 2016, Suzuki K. Poulose wrote:

> On 04/04/16 11:42, Anna-Maria Gleixner wrote:
> > Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> > hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> > CPU_DOWN_PREPARE are processed on the hotplugged cpu. Due to this SMP
> > function calls are no longer required.
> > 
> > Replace smp_call_function_single() with a direct call of
> > hw_breakpoint_reset(). To keep the calling convention, interrupts are
> > explicitely disabled around the call.
> 
> While you are at it, could you please also fix a similar instance
> in arch/arm64/kernel/debug-monitors.c: hw_breakpoint_reset_notify() ?

I already sent a patch for it, but I misspelled the arm mailinglist
address... I bounced it to the mailinglist.

Anna-Maria
