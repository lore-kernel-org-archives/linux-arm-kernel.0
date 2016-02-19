From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Feb 2016 17:13:30 +0000
Subject: [PATCH] iommu/arm-smmu-v2: Add support for 16 bit VMID
In-Reply-To: <1455819817-8432-1-git-send-email-tchalamarla@caviumnetworks.com>
References: <1455819817-8432-1-git-send-email-tchalamarla@caviumnetworks.com>
Message-ID: <20160219171329.GO27062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 10:23:37AM -0800, tchalamarla at caviumnetworks.com wrote:
> From: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> 
> ARM-SMMUv2 supports upto 16 bit VMID. This patch enables
> 16 bit VMID when requested from device-tree.
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt          |  2 ++
>  drivers/iommu/arm-smmu.c                            | 21 ++++++++++++++++++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 7180745..bb7e569 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -55,6 +55,8 @@ conditions.
>                    aliases of secure registers have to be used during
>                    SMMU configuration.
>  
> +- smmu-enable-vmid16 : Enable 16 bit VMID, if allowed.

Why do we need a new property for this, given that we can detect it
from the ID registers? I can't think of a reason why we wouldn't use
16-bit VMIDs if they were available to us.

Will
