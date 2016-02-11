From: lars.persson@axis.com (Lars Persson)
Date: Thu, 11 Feb 2016 15:04:37 +0100
Subject: [PATCH v2 3/8] arm: add device-tree SoC bindings for Axis Artpec-6
In-Reply-To: <cover.1455198819.git.larper@axis.com>
References: <cover.1455198819.git.larper@axis.com>
Message-ID: <0f096d1ad277cf94032ca274ced0cb35cb5d967c.1455198819.git.larper@axis.com>
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
index 0000000..203a305
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
+ARTPEC-6 DMA Configuration
+--------------------------
+
+The DMA configuration unit muxes dma request lines between single and burst
+alternatives.
+
+Required properties:
+- compatible: axis,artpec6-dmacfg
+- reg: Address and length of DMACFG register.
+
+Example:
+	dmacfg {
+		compatible = "axis,artpec6-dmacfg";
+		reg = <0xf8000010 4>;
+	};
+
+ARTPEC-6 Development board:
+---------------------------
+Required root node properties:
+- compatible = "axis,artpec6-dev-board", "axis,artpec6";
-- 
2.1.4
