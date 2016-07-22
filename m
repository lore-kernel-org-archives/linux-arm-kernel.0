From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jul 2016 17:51:07 +0100
Subject: [PATCH v3 0/6] Add support for privileged mappings
In-Reply-To: <20160719203655.16629-1-mitchelh@codeaurora.org>
References: <20160719203655.16629-1-mitchelh@codeaurora.org>
Message-ID: <20160722165107.GH16837@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 19, 2016 at 01:36:49PM -0700, Mitchel Humpherys wrote:
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

This all looks good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

It looks pretty fiddly to merge, however. How are you planning to get
this upstream?

Will
