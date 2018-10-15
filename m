From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 15 Oct 2018 14:11:52 +0100
Subject: [PATCH 3/4] dt-bindings: iommu/arm, smmu: add compatible string
 for Marvell
In-Reply-To: <1539604846-21151-4-git-send-email-hannah@marvell.com>
References: <1539604846-21151-1-git-send-email-hannah@marvell.com>
 <1539604846-21151-4-git-send-email-hannah@marvell.com>
Message-ID: <3ce1d67a-4e3c-e8d8-f7fc-79649f1def68@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/18 13:00, hannah at marvell.com wrote:
> From: Hanna Hawa <hannah@marvell.com>
> 
> Add specific compatible string for Marvell usage due errata of
> accessing 64bit registers of ARM SMMU, in AP806.
> 
> AP806 SOC use the generic ARM-MMU500, and there's no specific
> implementation of Marvell, this compatible is used for errata only.

Given that, I think something more specific like:

	"marvell,ap806-smmu", "arm,mmu-500";

would be most appropriate. Otherwise, if some future Marvell SoC were to 
ever come out with a *different* MMU-500 integration problem, you'd 
already have painted yourself into a corner.

Alternatively (or additionally), we could perhaps consider a separate 
property like "marvell,32bit-config-access", to mirror the existing 
handling of the secure integration bug.

Robin.

> Signed-off-by: Hanna Hawa <hannah@marvell.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce..92d7263 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -16,6 +16,7 @@ conditions.
>                           "arm,mmu-400"
>                           "arm,mmu-401"
>                           "arm,mmu-500"
> +                        "marvell,mmu-500"
>                           "cavium,smmu-v2"
>   
>                     depending on the particular implementation and/or the
> 
