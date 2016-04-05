From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 5 Apr 2016 14:59:26 +0200
Subject: [PATCH 1/2] iommu/dma: Restore scatterlist offsets correctly
In-Reply-To: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
References: <c14a93373a34633f6db89214ca2ddf69b0eaa1c3.1457637385.git.robin.murphy@arm.com>
Message-ID: <20160405125926.GI17838@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 07:28:12PM +0000, Robin Murphy wrote:
> With the change to stashing just the IOVA-page-aligned remainder of the
> CPU-page offset rather than the whole thing, the failure path in
> __invalidate_sg() also needs tweaking to account for that in the case of
> differing page sizes where the two offsets may not be equivalent.
> Similarly in __finalise_sg(), lest the architecture-specific wrappers
> later get the wrong address for cache maintenance on sync or unmap.
> 
> Fixes: 164afb1d85b8 ("iommu/dma: Use correct offset in map_sg")
> Reported-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Cc: stable at ver.kernel.org # v4.4+ ?


	Joerg
