From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 16 Mar 2010 11:41:31 +0000
Subject: [RFC PATCH 1/6] ARM: pmu: register IRQs at runtime
In-Reply-To: <1268414985-22699-2-git-send-email-will.deacon@arm.com>
References: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
	<1268414985-22699-2-git-send-email-will.deacon@arm.com>
Message-ID: <20100316114131.GC4116@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 12, 2010 at 05:29:39PM +0000, Will Deacon wrote:
> The current PMU infrastructure for ARM requires that the IRQs for the PMU
> device are fixed at compile time and are selected based on the ARCH_ or MACH_
> flags. This has the disadvantage of tying the Kernel down to a particular board
> as far as profiling is concerned.
> 
> This patch replaces the compile-time IRQ registration with a runtime mechanism
> which allows the IRQs to be passed in from the board initialisation files using
> the pmu_device_register() function.
> 
> A further advantage of this change is that there is scope for registering
> different types of performance counters in the future by adding a new field
> to the arm_pmu_type enumeration.
> 
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Cc: Jamie Iles <jamie.iles@picochip.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
Hi Will,

I much prefer this rather than the old static list that we had before. As an
aside, do you know of any ARM PMU's that need memory resources in addition to
the IRQ's? If so perhaps a platform_device might be an easy way of extending
this.

Anyway,

Acked-by: Jamie Iles <jamie.iles@picochip.com>

Jamie
