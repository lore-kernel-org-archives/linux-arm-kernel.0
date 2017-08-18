From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Fri, 18 Aug 2017 16:28:40 +0800
Subject: [PATCH v3 3/4] dt-bindings: PCI: rockchip: Add support for pcie wake
 irq
In-Reply-To: <20170818082841.22335-1-jeffy.chen@rock-chips.com>
References: <20170818082841.22335-1-jeffy.chen@rock-chips.com>
Message-ID: <20170818082841.22335-4-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add an optional interrupt for PCIE_WAKE pin.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 .../devicetree/bindings/pci/rockchip-pcie.txt        | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
index 1453a734c2f5..edd779f842fa 100644
--- a/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/rockchip-pcie.txt
@@ -22,10 +22,13 @@ Required properties:
 - phys: From PHY bindings: Phandle for the Generic PHY for PCIe.
 - phy-names:  MUST be "pcie-phy".
 - interrupts: Three interrupt entries must be specified.
-- interrupt-names: Must include the following names
-	- "sys"
-	- "legacy"
-	- "client"
+- interrupt-names: Include the following names
+	Required:
+		- "sys"
+		- "legacy"
+		- "client"
+	Optional:
+		- "wake"
 - resets: Must contain seven entries for each entry in reset-names.
 	   See ../reset/reset.txt for details.
 - reset-names: Must include the following names
@@ -76,10 +79,11 @@ pcie0: pcie at f8000000 {
 	clock-names = "aclk", "aclk-perf",
 		      "hclk", "pm";
 	bus-range = <0x0 0x1>;
-	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
-		     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
-		     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>;
-	interrupt-names = "sys", "legacy", "client";
+	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
+			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
+	interrupt-names = "sys", "legacy", "client", "wake";
 	assigned-clocks = <&cru SCLK_PCIEPHY_REF>;
 	assigned-clock-parents = <&cru SCLK_PCIEPHY_REF100M>;
 	assigned-clock-rates = <100000000>;
-- 
2.11.0
