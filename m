From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Nov 2018 09:24:16 +0100
Subject: [PATCH 4/5] ARM: dts: sun7i: Add CSI0 controller
In-Reply-To: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
Message-ID: <f0ff3a1705caa59230e540517258f5d9d7536d4b.1542097288.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CSI controller embedded in the A20 can be supported by our new driver.
Let's add it to our DT.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 9c52712af241..50a9e30ee18c 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -364,6 +364,19 @@
 			num-cs = <1>;
 		};
 
+		csi0: csi at 1c09000 {
+			compatible = "allwinner,sun7i-a20-csi",
+				     "allwinner,sun4i-a10-csi";
+			reg = <0x01c09000 0x1000>;
+			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_AHB_CSI0>, <&ccu CLK_CSI0>,
+				 <&ccu CLK_CSI_SCLK>, <&ccu CLK_DRAM_CSI0>;
+			clock-names = "ahb", "mod", "isp", "ram";
+			resets = <&ccu RST_CSI0>;
+			allwinner,csi-channels = <4>;
+			allwinner,has-isp;
+		};
+
 		emac: ethernet at 1c0b000 {
 			compatible = "allwinner,sun4i-a10-emac";
 			reg = <0x01c0b000 0x1000>;
-- 
git-series 0.9.1
