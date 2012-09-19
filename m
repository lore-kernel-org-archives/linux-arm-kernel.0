From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 07:59:45 +0000
Subject: [RFC 0/5] ARM: dma-mapping: New dma_map_ops to control IOVA more
 precisely
In-Reply-To: <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
References: <1346223335-31455-1-git-send-email-hdoyu@nvidia.com>
 <20120918124918.GK2505@amd.com>
 <20120919095843.d1db155e0f085f4fcf64ea32@nvidia.com>
Message-ID: <201209190759.46174.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 September 2012, Hiroshi Doyu wrote:
> I guess that it would work. Originally I thought that using DMA-API
> and IOMMU-API together in driver might be kind of layering violation
> since IOMMU-API itself is used in DMA-API. Only DMA-API used in driver
> might be cleaner. Considering that DMA API traditionally handling
> anonymous {bus,iova} address only, introducing the concept of
> specific address in DMA API may not be so encouraged, though.
> 
> It would be nice to listen how other SoCs have solved similar needs.

In general, I would recommend using only the IOMMU API when you have a device
driver that needs to control the bus virtual address space and that manages
a device that resides in its own IOMMU context. I would recommend using
only the dma-mapping API when you have a device that lives in a shared
bus virtual address space with other devices, and then never ask for
a specific bus virtual address.

Can you explain what devices you see that don't fit in one of those two
categories?

	Arnd
