From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 20 Jun 2013 22:08:45 +0200
Subject: [PATCH 7/9] documentation: iommu: add description of ARM System
 MMU binding
In-Reply-To: <1370889285-22799-8-git-send-email-will.deacon@arm.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-8-git-send-email-will.deacon@arm.com>
Message-ID: <20130620200845.GF11309@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 07:34:43PM +0100, Will Deacon wrote:
> This patch adds a description of the device tree binding for the ARM
> System MMU architecture.

Interesting, will this be a common driver to replace existing ARM IOMMU
drivers or is it a common driver for ARM IOMMUs found in future chips?

> +- smmu-parent   : When multiple SMMUs are chained together, this
> +                  property can be used to provide a phandle to the
> +                  parent SMMU (that is the next SMMU on the path going
> +                  from the mmu-masters towards memory) node for this
> +                  SMMU.

What happens when SMMUs are chained? Will the second SMMU seeing the DMA
just pass it through or is it translated again?


Thanks,

	Joerg
