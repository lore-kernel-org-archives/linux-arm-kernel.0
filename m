From: lars.persson@axis.com (Lars Persson)
Date: Thu, 11 Feb 2016 17:06:16 +0100
Subject: [PATCH v3 1/6] arm: add device-tree SoC bindings for Axis Artpec-6
In-Reply-To: <cover.1455205057.git.larper@axis.com>
References: <cover.1455205057.git.larper@axis.com>
Message-ID: <0a38251ad8ad1895a1744f43a58f6b161676af09.1455205057.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the Artpec-6 SoC.

Signed-off-by: Lars Persson <larper@axis.com>
---
 Documentation/devicetree/bindings/arm/axis.txt | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/axis.txt

diff --git a/Documentation/devicetree/bindings/arm/axis.txt b/Documentation/devicetree/bindings/arm/axis.txt
new file mode 100644
index 0000000..ae345e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/axis.txt
@@ -0,0 +1,29 @@
+Axis Communications AB
+ARTPEC series SoC Device Tree Bindings
+
+ARTPEC-6 ARM SoC
+================
+
+Required root node properties:
+- compatible = "axis,artpec6";
+
+ARTPEC-6 System Controller
+--------------------------
+
+The ARTPEC-6 has a system controller with mixed functions controlling DMA, PCIe
+and resets.
+
+Required properties:
+- compatible: "axis,artpec6-syscon", "syscon"
+- reg: Address and length of the register bank.
+
+Example:
+	syscon {
+		compatible = "axis,artpec6-syscon", "syscon";
+		reg = <0xf8000000 0x48>;
+	};
+
+ARTPEC-6 Development board:
+---------------------------
+Required root node properties:
+- compatible = "axis,artpec6-dev-board", "axis,artpec6";
-- 
2.1.4
