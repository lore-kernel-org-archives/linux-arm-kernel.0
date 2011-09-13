From: tony@atomide.com (Tony Lindgren)
Date: Tue, 13 Sep 2011 13:36:16 -0700
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20110913203616.GG24252@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110904 06:23]:
> OMAP WakeupGen is the interrupt controller extension used along
> with ARM GIC to wake the CPU out from low power states on
> external interrupts.
> 
> The WakeupGen unit is responsible for generating wakeup event
> from the incoming interrupts and enable bits. It is implemented
> in MPU always ON power domain. During normal operation,
> WakeupGen delivers external interrupts directly to the GIC.
...

> +	/*
> +	 * Override GIC architecture specific functions to add
> +	 * OMAP WakeupGen interrupt controller along with GIC
> +	 */
> +	gic_arch_extn.irq_mask = wakeupgen_mask;
> +	gic_arch_extn.irq_unmask = wakeupgen_unmask;
> +	gic_arch_extn.irq_set_wake = wakeupgen_set_wake;
> +	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;

As I've commented before, there should not be any need to tweak
the wakeupgen registers for each interrupt during the runtime.

AFAIK the wakeupgen registers only need to be armed every time
before entering idle.

Regards,

Tony
