From: will.deacon@arm.com (Will Deacon)
Date: Mon, 23 Jan 2017 17:39:58 +0000
Subject: [PATCH v2 2/2] iommu/dma: Implement PCI allocation optimisation
In-Reply-To: <db8af3d98f2a717c51d007c9c36d3b8eb1acd9a1.1484572209.git.robin.murphy@arm.com>
References: <d899aa686e7c8cb45142fa6785aa539ef3b88dec.1484572209.git.robin.murphy@arm.com>
 <db8af3d98f2a717c51d007c9c36d3b8eb1acd9a1.1484572209.git.robin.murphy@arm.com>
Message-ID: <20170123173957.GD28914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 01:24:55PM +0000, Robin Murphy wrote:
> Whilst PCI devices may have 64-bit DMA masks, they still benefit from
> using 32-bit addresses wherever possible in order to avoid DAC (PCI) or
> longer address packets (PCIe), which may incur a performance overhead.
> Implement the same optimisation as other allocators by trying to get a
> 32-bit address first, only falling back to the full mask if that fails.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/dma-iommu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)

Looks good to me, and has the added benefit of getting PCI ethernet
working on Juno when using the SMMU. Unintended side-effect, but:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
