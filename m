From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 6 Mar 2018 11:47:20 +0000
Subject: [RFC 3/5] dt-bindings: arm-smmu: Add reserved-msi-region
In-Reply-To: <1520312368-7068-4-git-send-email-jitendra.bhivare@broadcom.com>
References: <1520312368-7068-1-git-send-email-jitendra.bhivare@broadcom.com>
 <1520312368-7068-4-git-send-email-jitendra.bhivare@broadcom.com>
Message-ID: <9aeb8e14-2a14-d71b-7970-055ed04a131c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/18 04:59, Jitendra Bhivare wrote:
> iPROC SoC has a special device window to treat GICv3 ITS MSI.

Ugh, really? After preferably printing out 100 copies of the SBSA, 
binding them all together and dropping the lot onto the hardware 
designers from a great height, could you clarify what exactly the 
special behaviour is here?

Robin.

> Current code maps MSI to IOVA space. Add SMMU node property to use
> direct mappings for MSI region.
> 
> This property is read and reserved when arm_smmu_get_resv_regions
> gets called.
> 
> Signed-off-by: Jitendra Bhivare <jitendra.bhivare@broadcom.com>
> ---
>   Documentation/devicetree/bindings/iommu/arm,smmu.txt | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 8a6ffce..13fa2b9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -71,6 +71,15 @@ conditions.
>                     or using stream matching with #iommu-cells = <2>, and
>                     may be ignored if present in such cases.
>   
> +- reserved-msi-region: MSI region to be reserved with specific prot in IOVA
> +		  space for direct mapping. The region is specified in tuple
> +		  of (busno,prot,bus_addr,size).
> +
> +- #region-address-cells: specifies number of cells needed to encode bus_addr
> +
> +- #region-size-cells: specifies number of cells needed to encode size
> +
> +
>   ** Deprecated properties:
>   
>   - mmu-masters (deprecated in favour of the generic "iommus" binding) :
> @@ -95,6 +104,9 @@ conditions.
>                                <0 36 4>,
>                                <0 37 4>;
>                   #iommu-cells = <1>;
> +		#region-address-cells = <1>;
> +		#region-size-cells = <1>;
> +		reserved-msi-region = <0x0 0x1a 0x63c3000 0x8000>;
>           };
>   
>           /* device with two stream IDs, 0 and 7 */
> 
