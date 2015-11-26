From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 26 Nov 2015 13:30:02 +0100
Subject: [PATCH] arm64/dma-mapping: Fix sizes in __iommu_{alloc,free}_attrs
In-Reply-To: <74bd0f4e1ecda45febc55c6c6fe0d3d616c283d0.1446643360.git.robin.murphy@arm.com>
References: <74bd0f4e1ecda45febc55c6c6fe0d3d616c283d0.1446643360.git.robin.murphy@arm.com>
Message-ID: <20151126123002.GJ2064@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 01:23:52PM +0000, Robin Murphy wrote:
> The iommu-dma layer does its own size-alignment for coherent DMA
> allocations based on IOMMU page sizes, but we still need to consider
> CPU page sizes for the cases where a non-cacheable CPU mapping is
> created. Whilst everything on the alloc/map path seems to implicitly
> align things enough to make it work, some functions used by the
> corresponding unmap/free path do not, which leads to problems freeing
> odd-sized allocations. Either way it's something we really should be
> handling explicitly, so do that to make both paths suitably robust.
> 
> Reported-by: Yong Wu <yong.wu@mediatek.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Has this been merged through the arm tree or should I submit it as a fix
for 4.4?


	Joerg
