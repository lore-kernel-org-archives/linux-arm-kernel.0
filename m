From: will.deacon@arm.com (Will Deacon)
Date: Wed, 30 Jul 2014 12:04:25 +0100
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140730110425.GI12239@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Fri, Jul 04, 2014 at 04:29:17PM +0100, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - clarify that disabling an IOMMU DT node may not disable translation
> - be more explicit that examples are only examples
> - add multi-ID master example
> 
> Changes in v3:
> - use #iommu-cells instead of #address-cells/#size-cells
> - drop optional iommu-names property
> 
> Changes in v2:
> - add notes about "dma-ranges" property (drop note from commit message)
> - document priorities of "iommus" property vs. "dma-ranges" property
> - drop #iommu-cells in favour of #address-cells and #size-cells
> - remove multiple-master device example
> 
>  Documentation/devicetree/bindings/iommu/iommu.txt | 172 ++++++++++++++++++++++
>  1 file changed, 172 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/iommu.txt

I'm concerned that this patch hasn't been picked up for 3.17 (I can't see it
in -next). If we want to move the ARM SMMU driver over to this new binding,
we can't keep dragging our feet for much longer as I *really* don't plan to
support two bindings in parallel (one is complicated enough already).

Any chance we can see this merged, please?

Will
