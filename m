From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 Jul 2014 18:37:09 -0400
Subject: [PATCH 0/3 V2] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <1404314468-7674-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1404314468-7674-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140708223709.GH13433@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Suravee,

On Wed, Jul 02, 2014 at 10:21:05AM -0500, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch set introduces support for MSI(-X) in GICv2m specification,
> which is implemented in some variation of GIC400 (e.g. gic-400+).
> 
> This depends on and has been tested with the V7 of "Add support for PCI in AArch64"
> (https://lkml.org/lkml/2014/3/14/320).
> 
> Changes in V2:
> Re-architect the code to:
>     * Use irq_chip for gicv2m instead of using the gic_chip (per Marc suggestion).
>     * Remove the overwriting of arch_setup_msi_irq and arch_setup_msi_irqs
>       (per Marc suggestion).
>     * Add devicetree matching for gic-400-plus for v2m stuff instread of
>       re-using gic-400 just to be clear.
>     * Misc fix/clean up per Mark Rutland and Marc Zyngier comments
> 
> Suravee Suthikulpanit (3):
>   irqchip: gic: Add binding probe for ARM GIC400
>   irqchip: gic: Restructuring ARM GIC code
>   irqchip: gic: Add supports for ARM GICv2m MSI(-X)

I've now pulled in the first two patches of Marc's series into
irqchip/gic.  Could you please rebase your changes on top of that?

Also, please get a handle on git send-email.  This series had broken
threading and was sent out of order.

thx,

Jason.
