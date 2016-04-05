From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 5 Apr 2016 10:26:50 +0100
Subject: [PATCH] arm64: hw-breakpoint: Remove superfluous SMP function call
In-Reply-To: <1459766569-17237-1-git-send-email-anna-maria@linutronix.de>
References: <1459766569-17237-1-git-send-email-anna-maria@linutronix.de>
Message-ID: <570384DA.6010805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/16 11:42, Anna-Maria Gleixner wrote:
> Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged cpu. Due to this SMP
> function calls are no longer required.
>
> Replace smp_call_function_single() with a direct call of
> hw_breakpoint_reset(). To keep the calling convention, interrupts are
> explicitely disabled around the call.

While you are at it, could you please also fix a similar instance
in arch/arm64/kernel/debug-monitors.c: hw_breakpoint_reset_notify() ?

Thanks
Suzuki
