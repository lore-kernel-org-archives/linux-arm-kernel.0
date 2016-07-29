From: will.deacon@arm.com (Will Deacon)
Date: Fri, 29 Jul 2016 11:06:53 +0100
Subject: [PATCH v5 0/6] Add support for privileged mappings
In-Reply-To: <20160727234208.2101-1-mitchelh@codeaurora.org>
References: <20160727234208.2101-1-mitchelh@codeaurora.org>
Message-ID: <20160729100653.GC16593@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 27, 2016 at 04:42:02PM -0700, Mitchel Humpherys wrote:
> The following patch to the ARM SMMU driver:
> 
>     commit d346180e70b91b3d5a1ae7e5603e65593d4622bc
>     Author: Robin Murphy <robin.murphy@arm.com>
>     Date:   Tue Jan 26 18:06:34 2016 +0000
>     
>         iommu/arm-smmu: Treat all device transactions as unprivileged
> 
> started forcing all SMMU transactions to come through as "unprivileged".
> The rationale given was that:
> 
>   (1) There is no way in the IOMMU API to even request privileged mappings.
> 
>   (2) It's difficult to implement a DMA mapper that correctly models the
>       ARM VMSAv8 behavior of unprivileged-writeable =>
>       privileged-execute-never.
> 
> This series rectifies (1) by introducing an IOMMU API for privileged
> mappings and implements it in io-pgtable-arm.
> 
> This series rectifies (2) by introducing a new dma attribute
> (DMA_ATTR_PRIVILEGED) for users of the DMA API that need privileged
> mappings which are inaccessible to lesser-privileged execution levels, and
> implements it in the arm64 IOMMU DMA mapper.  The one known user (pl330.c)
> is converted over to the new attribute.
> 
> Jordan and Jeremy can provide more info on the use case if needed, but the
> high level is that it's a security feature to prevent attacks such as [1].
> 
> Joerg, the v3 series was previously acked by Will [2].  He also recommended
> that we take all of this through your tree since it's touching multiple
> subsystems [3].  Can you please take a look?  Thanks!

You forgot to add my ack to the patches, so if you need it again:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
