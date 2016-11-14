From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 14 Nov 2016 16:59:31 +0100
Subject: [PATCH v4 1/2] iommu/dma: Implement dma_{map,unmap}_resource()
In-Reply-To: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy@arm.com>
References: <d1cbd5ce714ce3c978aa8bfcb31def87d7919198.1479125555.git.robin.murphy@arm.com>
Message-ID: <20161114155931.GA14829@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 12:16:26PM +0000, Robin Murphy wrote:
> With the new dma_{map,unmap}_resource() functions added to the DMA API
> for the benefit of cases like slave DMA, add suitable implementations to
> the arsenal of our generic layer. Since cache maintenance should not be
> a concern, these can both be standalone callback implementations without
> the need for arch code wrappers.
> 
> CC: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v4: Add the missed static qualifier (thanks Catalin)
> 
>  drivers/iommu/dma-iommu.c | 24 +++++++++++++++++++++---
>  include/linux/dma-iommu.h |  4 ++++
>  2 files changed, 25 insertions(+), 3 deletions(-)

Applied both, thanks Robin.
