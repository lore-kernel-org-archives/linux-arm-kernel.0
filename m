From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 16:24:59 -0600
Subject: [PATCH v3 02/10] devicetree: Add generic IOMMU device tree
 bindings
In-Reply-To: <1403815790-8548-3-git-send-email-thierry.reding@gmail.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <53B1E3BB.1030407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2014 02:49 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346

> diff --git a/Documentation/devicetree/bindings/iommu/iommu.txt b/Documentation/devicetree/bindings/iommu/iommu.txt

> +When an "iommus" property is specified in a device tree node, the IOMMU will
> +be used for address translation. If a "dma-ranges" property exists in the
> +device's parent node it will be ignored. An exception to this rule is if the
> +referenced IOMMU is disabled, in which case the "dma-ranges" property of the
> +parent shall take effect.

I wonder how useful that paragraph is. The fact that someone disabled a
particular IOMMU's node doesn't necessarily mean that the HW can
actually do that; an IOMMU might always be active in HW and always
translate accesses by some master. In that case, the fallback to
dma-ranges wouldn't correlate with what the HW actually does. Perhaps
all we need is to add a note to that effect here?
