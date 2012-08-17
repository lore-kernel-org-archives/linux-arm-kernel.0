From: tony@atomide.com (Tony Lindgren)
Date: Fri, 17 Aug 2012 02:29:06 -0700
Subject: [PATCH v2 28/31] arm64: Generic timers support
In-Reply-To: <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-29-git-send-email-catalin.marinas@arm.com>
Message-ID: <20120817092904.GS11011@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:00]:
> From: Marc Zyngier <marc.zyngier@arm.com>
> 
> This patch adds support for the ARM generic timers with A64 instructions
> for accessing the timer registers. It uses the physical counter as the
> clock source and the virtual counter as sched_clock.
> 
> The timer frequency can be specified via DT or read from the CNTFRQ_EL0
> register. The physical counter is also accessible from user space
> allowing fast gettimeofday() implementation.

Can we always assume we can boot the kernel with ARM generic timers
and interrupts?

If so, maybe that should be mentioned in the booting requirements doc as
that means we can delay SoC specific initialization quite a bit and boot
with generic kernel to the initramfs ;)

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
