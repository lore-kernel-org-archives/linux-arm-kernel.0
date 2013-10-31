From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Oct 2013 01:17:15 +0000
Subject: [PATCH 6/6] documentation/iommu: Update description of ARM
 System MMU binding
In-Reply-To: <1382127195-15261-7-git-send-email-andreas.herrmann@calxeda.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-7-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20131031011715.GF28613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 09:13:15PM +0100, Andreas Herrmann wrote:
> This patch adds descriptions fore new properties of device tree
> binding for the ARM SMMU architecture. These properties control
> arm-smmu driver options.
> 
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index e34c6cd..de88cf9 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -48,6 +48,17 @@ conditions.
>                    from the mmu-masters towards memory) node for this
>                    SMMU.
>  
> +- arm,smmu-isolate-devices : Enable device isolation for all masters
> +                             of this SMMU. Ie. each master will be
> +                             attached to its own iommu domain.
> +
> +- arm,smmu-secure-config-access : Enable proper handling of buggy
> +                                  implementations that always use
> +                                  secure access to SMMU configuration
> +                                  registers. In this case non-secure
> +                                  aliases of secure registers have to
> +                                  be used during SMMU configuration.

Why are you using the "arm" vendor prefix for the secure config access
stuff? Wouldn't it make more sense to use "calxeda", just in case somebody
else finds a different way to wire things up in this regard?

Will
