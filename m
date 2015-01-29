From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 10:57:25 -0800
Subject: [PATCH URGENT] arm: dma-mapping: Set DMA IOMMU ops in
 arm_iommu_attach_device()
In-Reply-To: <2085044.xTrZHjchoH@diego>
References: <1422022909-31044-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2085044.xTrZHjchoH@diego>
Message-ID: <20150129185725.GA18628@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 01:25:35AM +0100, Heiko St?bner wrote:
> Hi Arnd, Olof,
> 
> Am Freitag, 23. Januar 2015, 16:21:49 schrieb Laurent Pinchart:
> > Commit 4bb25789ed28228a ("arm: dma-mapping: plumb our iommu mapping ops
> > into arch_setup_dma_ops") moved the setting of the DMA operations from
> > arm_iommu_attach_device() to arch_setup_dma_ops() where the DMA
> > operations to be used are selected based on whether the device is
> > connected to an IOMMU. However, the IOMMU detection scheme requires the
> > IOMMU driver to be ported to the new IOMMU of_xlate API. As no driver
> > has been ported yet, this effectively breaks all IOMMU ARM users that
> > depend on the IOMMU being handled transparently by the DMA mapping API.
> > 
> > Fix this by restoring the setting of DMA IOMMU ops in
> > arm_iommu_attach_device() and splitting the rest of the function into a
> > new internal __arm_iommu_attach_device() function, called by
> > arch_setup_dma_ops().
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> in the original submission arm at kernel.org was not included, but it looks like 
> the patch should go through arm-soc.
> 
> We have two tags
> 	Acked-by: Will Deacon <will.deacon@arm.com>
> 	Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> Can you find the original patch somehow or should it be resend to include 
> arm at kernel.org ?

The patch was posted on a list that I am subscribed to, so it popped up in
the same thread this time. I've applied it to fixes for 3.19.

Thanks,

-Olof
