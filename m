From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu,  1 Mar 2018 18:18:32 +0800
Subject: [RESEND PATCH v6 09/14] dt-bindings: iommu/rockchip: Add clock
 property
In-Reply-To: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
References: <20180301101837.27969-1-jeffy.chen@rock-chips.com>
Message-ID: <20180301101837.27969-10-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock property, since we are going to control clocks in rockchip
iommu driver.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/iommu/rockchip,iommu.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
index 2098f7732264..6ecefea1c6f9 100644
--- a/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
+++ b/Documentation/devicetree/bindings/iommu/rockchip,iommu.txt
@@ -14,6 +14,11 @@ Required properties:
                     "single-master" device, and needs no additional information
                     to associate with its master device.  See:
                     Documentation/devicetree/bindings/iommu/iommu.txt
+- clocks          : A list of clocks required for the IOMMU to be accessible by
+                    the host CPU.
+- clock-names     : Should contain the following:
+	"iface" - Main peripheral bus clock (PCLK/HCL) (required)
+	"aclk"  - AXI bus clock (required)
 
 Optional properties:
 - rockchip,disable-mmu-reset : Don't use the mmu reset operation.
@@ -27,5 +32,7 @@ Example:
 		reg = <0xff940300 0x100>;
 		interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "vopl_mmu";
+		clocks = <&cru ACLK_VOP1>, <&cru HCLK_VOP1>;
+		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
 	};
-- 
2.11.0
