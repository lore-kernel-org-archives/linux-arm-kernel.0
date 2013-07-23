From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 23 Jul 2013 11:23:34 +0100
Subject: [PATCH v2 1/3] drivers: clocksource: configure event stream for
 ARM arch timer
In-Reply-To: <1374492082-13686-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492082-13686-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492082-13686-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130723102334.GC3748@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 22, 2013 at 12:21:20PM +0100, Sudeep KarkadaNagesha wrote:
> From: Will Deacon <will.deacon@arm.com>
> 
> The ARM architected timer can generate events (used for waking up
> CPUs executing the wfe instruction) at a frequency represented as a
> power-of-2 divisor of the clock rate.
> 
> This patch configures the event stream, aiming for a period of 100us
> between events. This can be used to implement wfe-based timeouts for
> userspace locking implementations.
...
> --- a/include/clocksource/arm_arch_timer.h
> +++ b/include/clocksource/arm_arch_timer.h
> @@ -29,6 +29,8 @@
>  #define ARCH_TIMER_PHYS_ACCESS		0
>  #define ARCH_TIMER_VIRT_ACCESS		1
>  
> +#define ARCH_TIMER_EVT_STREAM_FREQ	10000	/* 100us */

BTW, if user-space starts using this, it will become an ABI. Is this the
right frequency?

In addition, do we want to expose this via hwcap? Something like
HWCAP_EVSTR100US?

-- 
Catalin
