From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 10 Nov 2016 16:59:39 +0100
Subject: [PATCH] iommu/dma-iommu: properly respect configured address
 space size
In-Reply-To: <68e7a18b-739e-b73e-eacf-3cb6c1bd279a@arm.com>
References: <CGME20161107130625eucas1p2dd23c07010b4f3eddb6c6540ed802246@eucas1p2.samsung.com>
 <1478523973-8828-1-git-send-email-m.szyprowski@samsung.com>
 <68e7a18b-739e-b73e-eacf-3cb6c1bd279a@arm.com>
Message-ID: <20161110155938.GI2078@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 11:37:23AM +0000, Robin Murphy wrote:
> TBH I've been pondering ripping the size stuff out of dma-iommu, as it
> all stems from me originally failing to understand what dma_32bit_pfn is
> actually for.

The point of dma_32bit_pfn is to allocate dma-address below 4G by
default. This is a performance optimization so that even devices capable
of 64bit DMA are using SAC by default instead of DAC.

Since it is the goal to share a dma-iommu implemenation between
architectures, I would rather prefer not to rip this stuff out.


	Joerg
