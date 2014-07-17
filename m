From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 17 Jul 2014 09:18:54 -0400
Subject: [PATCH 0/4 V3] irqchip: gic: Introduce ARM GICv2m MSI(-X) support
In-Reply-To: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1404947104-21345-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20140717131854.GN13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 06:05:00PM -0500, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch set introduces support for MSI(-X) in GICv2m specification,
> which is implemented in some variation of GIC400.
> 
> This depends on and has been tested with the V7 of"Add support for PCI in AArch64"
> (https://lkml.org/lkml/2014/3/14/320).
> 
> Changes in V3:
>     * Rebase to git://git.infradead.org/users/jcooper/linux.git irqchip/gic
>       (per Jason Cooper request)
>     * Misc fix/clean up per Mark Rutland comments
>     * Minor Clean up in the driver/irqchip/irq-gic-v2m.c: alloc_msi_irqs()
>     * Patch 4 is new to the series:
>         * Add ARM64-specific version arch_setup_msi_irqs() to allow support
>           for Multiple MSI.
>         * Add support for Multiple MSI for GICv2m.
> 
> Suravee Suthikulpanit (4):
>   irqchip: gic: Add binding probe for ARM GIC400
>   irqchip: gic: Restructuring ARM GIC code
>   irqchip: gic: Add supports for ARM GICv2m MSI(-X)
>   irqchip: gicv2m: Add support for multiple MSI for ARM64 GICv2m

Ok, patch #1 applied to irqchip/urgent.  Patches 2 and 3 applied to
irqchip/gic with irqchip/urgent merged in.  To facilitate
testing/merging, I've prepared an unsigned tag for you on the
irqchip/gic branch:

  git://git.infradead.org/users/jcooper/linux.git tags/deps-irqchip-gic-3.17-2

Unless you tell me I broke something horribly, this tag and irqchip/gic
up to that point are stable.

thx,

Jason.
