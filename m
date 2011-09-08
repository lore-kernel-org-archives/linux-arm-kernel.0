From: khilman@ti.com (Kevin Hilman)
Date: Thu, 08 Sep 2011 11:27:25 -0700
Subject: [PATCH 13/25] OMAP4: PM: Add WakeupGen module as OMAP
	gic_arch_extn
In-Reply-To: <1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Sun, 4 Sep 2011 19:24:14 +0530")
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-14-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <878vpyhotu.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> OMAP WakeupGen is the interrupt controller extension used along
> with ARM GIC to wake the CPU out from low power states on
> external interrupts.
>
> The WakeupGen unit is responsible for generating wakeup event
> from the incoming interrupts and enable bits. It is implemented
> in MPU always ON power domain. During normal operation,
> WakeupGen delivers external interrupts directly to the GIC.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

[...]

> +#ifdef CONFIG_PM
> +/*
> + * Masking wakeup irqs is handled by the IRQCHIP_MASK_ON_SUSPEND flag,
> + * so no action is necessary in set_wake, but implement an empty handler
> + * here to prevent enable_irq_wake() returning an error.
> + * FIXME: Remove the dummy handler once gen irq code fix above.
> + */

Just curious... is there a fix for this pending for v3.2?

Kevin
