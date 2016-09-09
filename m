From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 9 Sep 2016 15:42:22 +0100
Subject: [PATCH v6.1] iommu/dma: Add support for mapping MSIs
In-Reply-To: <33fb440d91a5fe8c3e7dc8a5e12d83a5253911dd.1473242018.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
 <2da5fca62886afd46cd2a5f7da1da872ee4a833d.1473173789.git.robin.murphy@arm.com>
 <33fb440d91a5fe8c3e7dc8a5e12d83a5253911dd.1473242018.git.robin.murphy@arm.com>
Message-ID: <57D2CA4E.3060101@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 07/09/16 10:55, Robin Murphy wrote:
> When an MSI doorbell is located downstream of an IOMMU, attaching
> devices to a DMA ops domain and switching on translation leads to a rude
> shock when their attempt to write to the physical address returned by
> the irqchip driver faults (or worse, writes into some already-mapped
> buffer) and no interrupt is forthcoming.
> 
> Address this by adding a hook for relevant irqchip drivers to call from
> their compose_msi_msg() callback, to swizzle the physical address with
> an appropriatly-mapped IOVA for any device attached to one of our DMA
> ops domains.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> CC: linux-kernel at vger.kernel.org
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for the quick respin.

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
