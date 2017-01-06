From: joro@8bytes.org (Joerg Roedel)
Date: Fri, 6 Jan 2017 12:06:27 +0100
Subject: [PATCH V8 1/9] iommu: add IOMMU_PRIV attribute
In-Reply-To: <1483362764-11990-2-git-send-email-sricharan@codeaurora.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
 <1483362764-11990-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170106110627.GO17255@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 02, 2017 at 06:42:36PM +0530, Sricharan R wrote:
> From: Mitchel Humpherys <mitchelh@codeaurora.org>
> 
> Add the IOMMU_PRIV attribute, which is used to indicate privileged
> mappings.
> 
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> Tested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>  include/linux/iommu.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 0ff5111..8c15ada 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -31,6 +31,7 @@
>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>  #define IOMMU_NOEXEC	(1 << 3)
>  #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
> +#define IOMMU_PRIV	(1 << 5) /* privileged */

Since this is a new generic global flag, can you please add a more
verbose comment telling what a 'privileged' mapping is about in the
iommu-case? We should have a clear defined semantic for this flag or we
might end up with different meanings for it with different
iommu-hardware.


	Joerg
