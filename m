From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 7 Jan 2016 13:38:25 +0100
Subject: [PATCH RESEND] iommu/dma: Use correct offset in map_sg
In-Reply-To: <8317d001da4f48831fa23d8d7729a4659ac72b49.1451924092.git.robin.murphy@arm.com>
References: <4812a34857b081e45c36d7e887840f3675da74dc.1450457730.git.robin.murphy@arm.com>
 <8317d001da4f48831fa23d8d7729a4659ac72b49.1451924092.git.robin.murphy@arm.com>
Message-ID: <20160107123824.GI19149@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 04:19:42PM +0000, Robin Murphy wrote:
> When mapping a non-page-aligned scatterlist entry, we copy the original
> offset to the output DMA address before aligning it to hand off to
> iommu_map_sg(), then later adding the IOVA page address portion to get
> the final mapped address. However, when the IOVA page size is smaller
> than the CPU page size, it is the offset within the IOVA page we want,
> not that within the CPU page, which can easily be larger than an IOVA
> page and thus result in an incorrect final address.
> 
> Fix the bug by taking only the IOVA-aligned part of the offset as the
> basis of the DMA address, not the whole thing.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Applied, thanks.
