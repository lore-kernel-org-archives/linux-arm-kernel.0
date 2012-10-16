From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 16 Oct 2012 09:50:16 +0900
Subject: [RFC 0/2] DMA-mapping & IOMMU - physically contiguous allocations
In-Reply-To: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
References: <1350309832-18461-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CAAQKjZMYFNMEnb2ue2aR+6AEbOixnQFyggbXrThBCW5VOznePg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/15 Marek Szyprowski <m.szyprowski@samsung.com>:
> Hello,
>
> Some devices, which have IOMMU, for some use cases might require to
> allocate a buffers for DMA which is contiguous in physical memory. Such
> use cases appears for example in DRM subsystem when one wants to improve
> performance or use secure buffer protection.
>
> I would like to ask if adding a new attribute, as proposed in this RFC
> is a good idea? I feel that it might be an attribute just for a single
> driver, but I would like to know your opinion. Should we look for other
> solution?
>

In addition, currently we have worked dma-mapping-based iommu support
for exynos drm driver with this patch set so this patch set has been
tested with iommu enabled exynos drm driver and worked fine. actually,
this feature is needed for secure mode such as TrustZone. in case of
Exynos SoC, memory region for secure mode should be physically
contiguous and also maybe OMAP but now dma-mapping framework doesn't
guarantee physically continuous memory allocation so this patch set
would make it possible.

Tested-by: Inki Dae <inki.dae@samsung.com>
Reviewed-by: Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
>
>
> Marek Szyprowski (2):
>   common: DMA-mapping: add DMA_ATTR_FORCE_CONTIGUOUS attribute
>   ARM: dma-mapping: add support for DMA_ATTR_FORCE_CONTIGUOUS attribute
>
>  Documentation/DMA-attributes.txt |    9 +++++++++
>  arch/arm/mm/dma-mapping.c        |   41 ++++++++++++++++++++++++++++++--------
>  include/linux/dma-attrs.h        |    1 +
>  3 files changed, 43 insertions(+), 8 deletions(-)
>
> --
> 1.7.9.5
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>
