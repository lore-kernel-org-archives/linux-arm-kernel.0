From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Dec 2015 11:51:03 +0000
Subject: [PATCH v2 2/2] Documentation: dt-bindings: Add option to
 workaround STE.VALID in Broadcom Vulcan
In-Reply-To: <1450346376-30920-2-git-send-email-pmallapp@broadcom.com>
References: <1450346376-30920-1-git-send-email-pmallapp@broadcom.com>
 <1450346376-30920-2-git-send-email-pmallapp@broadcom.com>
Message-ID: <20151217115102.GC11456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding devicetree since I'd like an Ack from them if possible]

On Thu, Dec 17, 2015 at 03:29:36PM +0530, Prem Mallappa wrote:
> Signed-off-by: Prem Mallappa <pmallapp@broadcom.com>

Please can you add a commit message for this?

> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index 947863a..9c1218e 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -43,6 +43,11 @@ the PCIe specification.
>  - hisilicon,broken-prefetch-cmd
>                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
>  
> +- broadcom,broken-ste-valid-check
> +                    : Broadcom specific, h/w peeks into more than just 
> +		      STE.VALID bit in "Bypass" mode. Enabling this, 
> +		      populates needed bits.

This should really describe more about what happens, I think. For example,

"Enable ATS and Stage-2 AArch64 translation in bypass STEs, since some
 hardware requires this in order for an STE to be treated as valid."

Will
