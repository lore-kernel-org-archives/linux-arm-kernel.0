From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Apr 2018 08:19:34 -0700
Subject: [PATCH v2 2/5] dma-mapping: Introduce dma_iommu_detach_device()
 API
In-Reply-To: <20180425101051.15349-2-thierry.reding@gmail.com>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
 <20180425101051.15349-2-thierry.reding@gmail.com>
Message-ID: <20180425151934.GC16075@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 12:10:48PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The dma_iommu_detach_device() API can be used by drivers to forcibly
> detach a device from an IOMMU that architecture code might have attached
> to. This is useful for drivers that need explicit control over the IOMMU
> using the IOMMU API directly.

Given that no one else implements it making it a generic API seems
rather confusing.  For now I'd rename it to
arm_dma_iommu_detach_device() and only implement it in arm.

Once I've got the dma mapping implementations consolidated to a small
enough number we could think about something like a device quirk that
tells the architecture to simply never even attach the iommu dma ops
to start with.
