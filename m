From: tfiga@chromium.org (Tomasz Figa)
Date: Tue, 21 Jun 2016 21:42:16 +0900
Subject: [PATCH v4 0/8] iommu/rockchip: Fix bugs and enable on ARM64
In-Reply-To: <20160621091732.GB28248@8bytes.org>
References: <1466483681-36110-1-git-send-email-tfiga@chromium.org>
 <20160621091732.GB28248@8bytes.org>
Message-ID: <CAAFQd5B8sxbZ6MymwDKL4vZkfQ-ej_bNh7tS1OhRC=X7-eie+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Tue, Jun 21, 2016 at 6:17 PM, Joerg Roedel <joro@8bytes.org> wrote:
>
> On Tue, Jun 21, 2016 at 01:34:33PM +0900, Tomasz Figa wrote:
> > This series intends mostly to enable support for ARM64 architecture
> > in the rockchip-iommu driver. On the way to do so, some bugs are also
> > fixed.
> >
> > The most important changes here are:
> >  - making the Rockchip IOMMU driver use DMA API for managing cache
> >    coherency of page tables,
> >  - making the Rockchip DRM driver not use DMA API on behalf of a virtual
> >    device (behind a virtual IOMMU) to allocate and map buffers, but
> >    instead proper DRM helpers and IOMMU API directly.
>
> Are these two parts dependent on each other or can the IOMMU and the DRM
> part merged independently?

In simple words, DRM patches depend on IOMMU patches.

More precisely: The IOMMU patches alone are supposed to not break
anything. Same goes for the first DRM patch (7/8). Only second DRM
patch (8/8) depends on changes introduced by its predecessors.

Best regards,
Tomasz
