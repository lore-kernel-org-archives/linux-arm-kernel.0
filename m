From: will.deacon@arm.com (Will Deacon)
Date: Fri, 31 Jul 2015 12:22:27 +0100
Subject: [PATCH v2 1/9] iommu/io-pgtable-arm: Allow appropriate DMA API use
In-Reply-To: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
References: <6999933bfa9b3d50853fd023d455c837a0d7ff23.1438195011.git.robin.murphy@arm.com>
Message-ID: <20150731112226.GB29497@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On Wed, Jul 29, 2015 at 07:46:04PM +0100, Robin Murphy wrote:
> Currently, users of the LPAE page table code are (ab)using dma_map_page()
> as a means to flush page table updates for non-coherent IOMMUs. Since
> from the CPU's point of view, creating IOMMU page tables *is* passing
> DMA buffers to a device (the IOMMU's page table walker), there's little
> reason not to use the DMA API correctly.
> 
> Allow IOMMU drivers to opt into DMA API operations for page table
> allocation and updates by providing their appropriate device pointer.
> The expectation is that an LPAE IOMMU should have a full view of system
> memory, so use streaming mappings to avoid unnecessary pressure on
> ZONE_DMA, and treat any DMA translation as a warning sign.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Changes since v1[1]:
> - Make device pointer mandatory and use DMA API unconditionally
> - Remove flush_pgtable callback entirely
> - Style, consistency and typo fixes

I think this is looking good now, thanks. I'll add it to my ARM SMMU queue
for 4.3.

Will
