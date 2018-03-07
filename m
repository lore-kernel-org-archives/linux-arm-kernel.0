From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 7 Mar 2018 13:01:37 +0000
Subject: [PATCH v7 09/14] dt-bindings: iommu/rockchip: Add clock property
In-Reply-To: <20180306032113.22247-6-jeffy.chen@rock-chips.com>
References: <20180306030252.3197-1-jeffy.chen@rock-chips.com>
 <20180306032113.22247-1-jeffy.chen@rock-chips.com>
 <20180306032113.22247-6-jeffy.chen@rock-chips.com>
Message-ID: <b7b58e44-82d5-4f7d-5f49-69f8d1a93279@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03/18 03:21, Jeffy Chen wrote:
> Add clock property, since we are going to control clocks in rockchip
> iommu driver.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v7: None
> Changes in v6:
> Fix dt-binding as Robin suggested.
> Use aclk and iface clk as Rob and Robin suggested, and split binding
> patch.
> 
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>   Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> index 2098f7732264..6ecefea1c6f9 100644
> --- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> +++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
> @@ -14,6 +14,11 @@ Required properties:
>                       "single-master" device, and needs no additional information
>                       to associate with its master device.  See:
>                       Documentation/devicetree/bindings/iommu/iommu.txt
> +- clocks          : A list of clocks required for the IOMMU to be accessible by
> +                    the host CPU.
> +- clock-names     : Should contain the following:
> +	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
> +	"aclk"  - AXI bus clock (required)
>   
>   Optional properties:
>   - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
> @@ -27,5 +32,7 @@ Example:
>   		reg = <0xff940300 0x100>;
>   		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
>   		interrupt-names = "vopl_mmu";
> +		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
> +		clock-names = "aclk", "iface";
>   		#iommu-cells = <0>;
>   	};
> 
