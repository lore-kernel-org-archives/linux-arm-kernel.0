From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 20:14:24 +0200
Subject: [RFC PATCH v2 7/7] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <1409680587-29818-8-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-8-git-send-email-will.deacon@arm.com>
Message-ID: <6595943.s3o5K6pyp9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 18:56:27 Will Deacon wrote:
> This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> actually called outside of a few drivers) into arch_setup_dma_ops, so
> that we can use IOMMUs for DMA transfers in a more generic fashion.
> 
> Since this significantly complicates the arch_setup_dma_ops function,
> it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> is not set, the iommu paramater is ignored and the normal ops are used
> instead.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> 

Looks great to me.

	Arnd
