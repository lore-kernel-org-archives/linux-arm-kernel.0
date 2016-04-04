From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 4 Apr 2016 17:06:46 +0300
Subject: [PATCH] arm64: hw-breakpoint: Remove superfluous SMP function call
In-Reply-To: <1459766569-17237-1-git-send-email-anna-maria@linutronix.de>
References: <1459766569-17237-1-git-send-email-anna-maria@linutronix.de>
Message-ID: <570274F6.3050602@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/4/2016 1:42 PM, Anna-Maria Gleixner wrote:

> Since commit 1cf4f629d9d2 ("cpu/hotplug: Move online calls to
> hotplugged cpu") it is ensured that callbacks of CPU_ONLINE and
> CPU_DOWN_PREPARE are processed on the hotplugged cpu. Due to this SMP

   CPU. My spell checker also trips over "hotplugged"...

> function calls are no longer required.
>
> Replace smp_call_function_single() with a direct call of
> hw_breakpoint_reset(). To keep the calling convention, interrupts are
> explicitely disabled around the call.

    Explicitly.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
[...]

MBR, Sergei
