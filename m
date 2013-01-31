From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 15:34:55 +0000
Subject: [PATCHv5 04/16] arm: arch_timer: standardise counter reading
In-Reply-To: <1359634539-9580-5-git-send-email-mark.rutland@arm.com>
References: <1359634539-9580-1-git-send-email-mark.rutland@arm.com>
 <1359634539-9580-5-git-send-email-mark.rutland@arm.com>
Message-ID: <20130131153455.GH12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 31, 2013 at 12:15:27PM +0000, Mark Rutland wrote:
> We're currently inconsistent with respect to our accesses to the
> physical and virtual counters, mixing and matching the two.
> 
> This patch introduces and uses a function pointer for accessing the
> correct counter based on whether we're using physical or virtual
> interrupts. All current accesses to the counter accessors are redirected
> through it.
> 
> When the driver is moved out to drivers/clocksource, there's the
> possibility that code called before the timer code is initialised will
> attempt to call arch_timer_read_counter (e.g. sched_clock for AArch64).
> To avoid having to have to check whether the timer has been initialised
> either in arch_timer_read_counter or one of it's callers, a default
> implementation is assigned that simply returns 0.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
