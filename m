From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Sep 2016 10:16:09 +0100
Subject: [PATCH 4.5/20] Docs: dt: document ARM SMMUv3 generic binding usage
In-Reply-To: <6067fc2b12b3bc681687753eedd941c8244c22fa.1473443407.git.robin.murphy@arm.com>
References: <cover.1473173789.git.robin.murphy@arm.com>
 <6067fc2b12b3bc681687753eedd941c8244c22fa.1473443407.git.robin.murphy@arm.com>
Message-ID: <20160912091608.GB23211@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 07:17:48PM +0100, Robin Murphy wrote:
> Now that we've ratified SMMUv3's use of the generic binding, document it.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index 7b94c88cf2ee..69a694f70bea 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -27,6 +27,12 @@ the PCIe specification.
>                        * "cmdq-sync" - CMD_SYNC complete
>                        * "gerror"    - Global Error activated
>  
> +- #iommu-cells      : See the generic IOMMU binding described in
> +                        devicetree/bindings/iommu/iommu.txt

That file has a weird "Notes:" section describing the application of
"iommus" to a PCI host bridge. We should probably rip that out, because
it seems to be going directly against the approach we've ended up taking.

In fact, replacing that with a cross reference to

  devicetree/bindings/pci/pci-iommu.txt

would make much more sense to me.

> +                      for details. For SMMUv3, must be 1, with each cell
> +                      describing a single stream ID. All possible stream
> +                      ID which a device may emit must be described.

IDs

Will
