From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 06 Feb 2017 13:22:00 +0100
Subject: IRQ masking hierarchy with GIC as the root
Message-ID: <1486383720.2275.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc and others,

in the conversion of the old GIC arch_extension to proper stacked IRQ
domain chips you added calls to irq_chip_mask_parent() to both the Tegra
LIC (drivers/irqchip/irq-tegra.c) and the i.MX GPC
(arch/arm/mach-imx/gpc.c).

Both IRQ controllers should be able to mask the IRQ on their own,
meaning the IRQ will not reach the GIC if it is masked at this hierarchy
level. Is it safe to remove the the call to mask the IRQ at the GIC
level, or is there something more to it that I don't (yet) see?

Thanks,
Lucas
