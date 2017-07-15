From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat, 15 Jul 2017 14:58:40 +0800
Subject: [PATCH v2 6/6] dt-bindings: Document the Rockchip RGA bindings
In-Reply-To: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
References: <1500101920-24039-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <1500101920-24039-7-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT bindings documentation for Rockchip RGA

Signed-off-by: Yakir Yang <ykk@rock-chips.com>
Signed-off-by: Jacob Chen <jacob-chen@iotwrt.com>
---
 .../devicetree/bindings/media/rockchip-rga.txt     | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-rga.txt

diff --git a/Documentation/devicetree/bindings/media/rockchip-rga.txt b/Documentation/devicetree/bindings/media/rockchip-rga.txt
new file mode 100644
index 0000000..966eba0
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip-rga.txt
@@ -0,0 +1,35 @@
+device-tree bindings for rockchip 2D raster graphic acceleration controller (RGA)
+
+RGA is a separate 2D raster graphic acceleration unit. It accelerates 2D
+graphics operations, such as point/line drawing, image scaling, rotation,
+BitBLT, alpha blending and image blur/sharpness.
+
+Required properties:
+- compatible: value should be one of the following
+		"rockchip,rk3228-rga";
+		"rockchip,rk3288-rga";
+		"rockchip,rk3399-rga";
+
+- interrupts: RGA interrupt number.
+
+- clocks: phandle to RGA sclk/hclk/aclk clocks
+
+- clock-names: should be "aclk" "hclk" and "sclk"
+
+- resets: Must contain an entry for each entry in reset-names.
+  See ../reset/reset.txt for details.
+- reset-names: should be "core" "axi" and "ahb"
+
+Example:
+SoC specific DT entry:
+	rga: rga at ff680000 {
+		compatible = "rockchip,rk3399-rga";
+		reg = <0xff680000 0x10000>;
+		interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "rga";
+		clocks = <&cru ACLK_RGA>, <&cru HCLK_RGA>, <&cru SCLK_RGA_CORE>;
+		clock-names = "aclk", "hclk", "sclk";
+
+		resets = <&cru SRST_RGA_CORE>, <&cru SRST_A_RGA>, <&cru SRST_H_RGA>;
+		reset-names = "core, "axi", "ahb";
+	};
-- 
2.7.4
