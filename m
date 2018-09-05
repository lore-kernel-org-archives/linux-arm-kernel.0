From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Wed,  5 Sep 2018 18:49:44 +0900
Subject: [PATCH 1/2] dt-bindings: phy: add UniPhier PCIe PHY description
In-Reply-To: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1536140985-6058-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1536140985-6058-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings for PHY interface built into PCIe controller implemented
in UniPhier SoCs.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../devicetree/bindings/phy/uniphier-pcie-phy.txt  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
new file mode 100644
index 0000000..1889d3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/uniphier-pcie-phy.txt
@@ -0,0 +1,31 @@
+Socionext UniPhier PCIe PHY bindings
+
+This describes the devicetree bindings for PHY interface built into
+PCIe controller implemented on Socionext UniPhier SoCs.
+
+Required properties:
+- compatible: Should contain one of the following:
+    "socionext,uniphier-ld20-pcie-phy" - for LD20 PHY
+    "socionext,uniphier-pxs3-pcie-phy" - for PXs3 PHY
+- reg: Specifies offset and length of the register set for the device.
+- #phy-cells: Must be zero.
+- clocks: A phandle to the clock gate for PCIe glue layer including
+	this phy.
+- resets: A phandle to the reset line for PCIe glue layer including
+	this phy.
+
+Optional properties:
+- socionext,syscon: A phandle to system control to set configurations
+	for phy.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+	pcie_phy: phy at 66038000 {
+		compatible = "socionext,uniphier-ld20-pcie-phy";
+		reg = <0x66038000 0x4000>;
+		#phy-cells = <0>;
+		clocks = <&sys_clk 24>;
+		resets = <&sys_rst 24>;
+		socionext,syscon = <&soc_glue>;
+	};
-- 
2.7.4
