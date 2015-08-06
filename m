From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Aug 2015 16:23:27 +0100
Subject: [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
In-Reply-To: <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
References: <cover.1438362603.git.robin.murphy@arm.com>
 <6ce6b501501f611297ae0eae31e07b0d2060eaae.1438362603.git.robin.murphy@arm.com>
Message-ID: <20150806152327.GH25483@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joerg,

On Fri, Jul 31, 2015 at 06:18:27PM +0100, Robin Murphy wrote:
> Taking inspiration from the existing arch/arm code, break out some
> generic functions to interface the DMA-API to the IOMMU-API. This will
> do the bulk of the heavy lifting for IOMMU-backed dma-mapping.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/Kconfig     |   7 +
>  drivers/iommu/Makefile    |   1 +
>  drivers/iommu/dma-iommu.c | 534 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-iommu.h |  84 ++++++++
>  include/linux/iommu.h     |   1 +
>  5 files changed, 627 insertions(+)
>  create mode 100644 drivers/iommu/dma-iommu.c
>  create mode 100644 include/linux/dma-iommu.h

We're quite keen to get this in for arm64, since we're without IOMMU DMA
ops and need to get something upstream. Do you think this is likely to
be merged for 4.3/4.4 or would we be better off doing our own
arch-private implementation instead?

Sorry to pester, but we've got people basing their patches and products
on this and I don't want to end up having to support out-of-tree code.

Cheers,

Will
