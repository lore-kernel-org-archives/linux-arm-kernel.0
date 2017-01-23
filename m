From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Jan 2017 17:40:13 +0000
Subject: [PATCH v2 1/2] iommu/dma: Stop getting dma_32bit_pfn wrong
In-Reply-To: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy@arm.com>
References: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy@arm.com>
Message-ID: <20170123174012.GE28914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 01:24:54PM +0000, Robin Murphy wrote:
> iommu_dma_init_domain() was originally written under the misconception
> that dma_32bit_pfn represented some sort of size limit for IOVA domains.
> Since the truth is almost the exact opposite of that, rework the logic
> and comments to reflect its real purpose of optimising lookups when
> allocating from a subset of the available 64-bit space.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Sending this as a v2 since both patches have been seen before, and #1 is
> ever so slightly tweaked. #2 applies on top of Eric's MSI series, since
> that seems ready to go now - there is a trivial merge conflict otherwise
> around the extra argument in the __alloc_iova() call.
> 
> Robin.
> 
>  drivers/iommu/dma-iommu.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)

Tested-by: Will Deacon <will.deacon@arm.com>

Will
