From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Mon, 23 Jul 2012 09:55:39 +0200
Subject: irq_find_mapping
Message-ID: <500D037B.9030304@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

I have just downloaded linux 3.5, and looked a bit at the IRQ DOMAINS 
implementation on ARM. There is something I do not understand.

The irq_find_mapping documentation states:
/**
 * irq_find_mapping() - Find a linux irq from an hw irq number.
 * @domain: domain owning this hardware interrupt
 * @hwirq: hardware irq number in that domain space
 *
 * This is a slow path, for use by generic code. It's expected that an
 * irq controller implementation directly calls the appropriate low level
 * mapping function.
 */

The code of the function obviously shows why irq_find_mapping should
not be called for anything but "legacy" domains.

However, in the Linux kernel on ARM, we find this function called in
the following files:
arch/arm/plat-versatile/fpga-irq.c
arch/arm/common/vic.c
arch/arm/common/gic.c
arch/arm/mach-omap2/irq.c
arch/arm/mach-at91/gpio.c
arch/arm/mach-exynos/common.c

Since most irq domains are "legacy" domains, I guess it does not matter.
Except for at91 gpios using a linear domains.

Should not this calls to irq_find_mapping be replaced with calls to 
the "approprate low level mapping function"?

-- 
                                                                Gilles.
