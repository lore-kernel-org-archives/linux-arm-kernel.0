From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 09:55:46 +0000
Subject: [PATCH V3 02/10] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
In-Reply-To: <1453209083-3358-3-git-send-email-tn@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-3-git-send-email-tn@semihalf.com>
Message-ID: <56BB0922.3040507@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 13:11, Tomasz Nowicki wrote:
> With the refator of gic_of_init(), GICv3/4 can be initialized
> by gic_init_bases() with gic distributor base address and gic
> redistributor region(s).
> 
> So get the redistributor region base addresses from MADT GIC
> redistributor subtable, and the distributor base address from
> GICD subtable to init GICv3 irqchip in ACPI way.
> 
> Note: GIC redistributor base address may also be provided in
> GICC structures on systems supporting GICv3 and above if the GIC
> Redistributors are not in the always-on power domain, this
> patch didn't implement such feature yet.
> Also, ACPI ITS initialization will be added in the following patches.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
