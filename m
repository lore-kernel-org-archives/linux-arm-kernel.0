From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 26 Jan 2015 11:42:29 +0100
Subject: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
 arm_iommu_attach_device()
In-Reply-To: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20150126104229.GB2312@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 04:21:49PM +0200, Laurent Pinchart wrote:
> Commit 4bb25789ed28228a ("arm: dma-mapping: plumb our iommu mapping ops
> into arch_setup_dma_ops") moved the setting of the DMA operations from
> arm_iommu_attach_device() to arch_setup_dma_ops() where the DMA
> operations to be used are selected based on whether the device is
> connected to an IOMMU. However, the IOMMU detection scheme requires the
> IOMMU driver to be ported to the new IOMMU of_xlate API. As no driver
> has been ported yet, this effectively breaks all IOMMU ARM users that
> depend on the IOMMU being handled transparently by the DMA mapping API.
> 
> Fix this by restoring the setting of DMA IOMMU ops in
> arm_iommu_attach_device() and splitting the rest of the function into a
> new internal __arm_iommu_attach_device() function, called by
> arch_setup_dma_ops().
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mm/dma-mapping.c | 53 +++++++++++++++++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 15 deletions(-)

I guess this patch will be merged by one of the ARM trees?


	Joerg
