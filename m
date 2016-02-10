From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 10 Feb 2016 10:16:31 +0000
Subject: [PATCH V3 03/10] irqchip,GICv3,ACPI: Add redistributor support
 via GICC structures.
In-Reply-To: <1453209083-3358-4-git-send-email-tn@semihalf.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-4-git-send-email-tn@semihalf.com>
Message-ID: <56BB0DFF.1040802@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/16 13:11, Tomasz Nowicki wrote:
> Following ACPI spec:
> On systems supporting GICv3 and above, GICR Base Address in MADT GICC
> structure holds the 64-bit physical address of the associated Redistributor.
> If all of the GIC Redistributors are in the always-on power domain,
> GICR structures should be used to describe the Redistributors instead,
> and this field must be set to 0.
> 
> It means that we have two ways to initialize registirbutors map.
> 1. via GICD structure which can accommodate many redistributors as a region
> 2. via GICC which is able to describe single redistributor
> 
> This patch is going to add support for second option.
> Considering redistributors, GICD and GICC subtables have be mutually
> exclusive. While discovering and mapping redistributor, we need to know
> its size in advance. For the GICC case, redistributor can be in
> a power-domain that is off, thus we cannot relay on GICR TYPER register.
> Therefore, we get GIC version from distributor register and map 2xSZ_64K
> for GICv3 and 4xSZ_64K for GICv4.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

This is incredibly convoluted, but I'm not sure there is a better way
given the current ACPI API. Still, it hurts.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
