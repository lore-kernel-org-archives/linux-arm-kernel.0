From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 4 Apr 2016 17:08:01 +0300
Subject: [PATCH] arm, hw-breakpoint: Remove superfluous SMP function call
In-Reply-To: <1459765920-15690-1-git-send-email-anna-maria@linutronix.de>
References: <1459765920-15690-1-git-send-email-anna-maria@linutronix.de>
Message-ID: <57027541.9080401@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2016 1:32 PM, Anna-Maria Gleixner wrote:

> Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged cpu. Due to this SMP
> function calls are no longer required.
>
> Replace smp_call_function_single() with a direct call of
> reset_ctrl_regs(). To keep the calling convention, interrupts are
> explicitely disabled around the call.

    Same typo as in ARM64 patch.

> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
[...]

MBR, Sergei
