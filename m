From: sricharan@codeaurora.org (Sricharan R)
Date: Fri, 21 Oct 2016 22:44:23 +0530
Subject: [PATCH 1/4] Docs: dt: document ARM SMMU clocks/powerdomains bindings
In-Reply-To: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
References: <1477070066-15044-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1477070066-15044-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the list of clocks and powerdomains required for the
smmu's register and bus access.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
index e862d148..ef465b0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
@@ -46,6 +46,14 @@ conditions.
                   Care must be taken to ensure the set of matched IDs
                   does not result in conflicts.
 
+- clock-names:	  Should be a pair of "smmu_iface_clk" and "smmu_bus_clk"
+		  required for smmu's register group access and interface
+		  clk for the smmu's underlying bus access.
+
+- clocks:	  Phandles for respective clocks described by clock-names.
+
+- power-domains:  If required for turning on the smmu's clocks.
+
 ** System MMU optional properties:
 
 - dma-coherent  : Present if page table walks made by the SMMU are
@@ -84,6 +92,10 @@ conditions.
                              <0 36 4>,
                              <0 37 4>;
                 #iommu-cells = <1>;
+		clocks = <&mmcc SMMU_MDP_AHB_CLK>,
+			 <&mmcc SMMU_MDP_AXI_CLK>;
+		clock-names = "smmu_iface_clk",
+			      "smmu_bus_clk";
         };
 
         /* device with two stream IDs, 0 and 7 */
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
