From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 21 Jun 2016 11:17:32 +0200
Subject: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
Message-ID: <20160621091732.GB28248@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2016 at 01:34:33PM +0900, Tomasz Figa wrote:
> This series intends mostly to enable support for ARM64 architecture
> in the rockchip-iommu driver. On the way to do so, some bugs are also
> fixed.
> 
> The most important changes here are:
>  - making the Rockchip IOMMU driver use DMA API for managing cache
>    coherency of page tables,
>  - making the Rockchip DRM driver not use DMA API on behalf of a virtual
>    device (behind a virtual IOMMU) to allocate and map buffers, but
>    instead proper DRM helpers and IOMMU API directly.

Are these two parts dependent on each other or can the IOMMU and the DRM
part merged independently?


	Joerg
