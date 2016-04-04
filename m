From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  5 Apr 2016 00:22:32 +0800
Subject: [PATCH RFC 3/5] ARM: dts: sun8i-h3: Add H3 Ethernet PHY device node
 to sun8i-h3.dtsi
In-Reply-To: <1459786954-12649-1-git-send-email-wens@csie.org>
References: <1459786954-12649-1-git-send-email-wens@csie.org>
Message-ID: <1459786954-12649-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner H3 SoC incorporates an Ethernet PHY, whose controls are
mapped to a system control register.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b0b0ed..9a28aeba9bc6 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -323,6 +323,15 @@
 		#size-cells = <1>;
 		ranges;
 
+		ephy: ethernet-phy at 01c00030 {
+			compatible = "allwinner,sun8i-h3-ephy";
+			reg = <0x01c00030 0x4>;
+			clocks = <&bus_gates 128>;
+			resets = <&ahb_rst 66>;
+			#clock-cells = <0>;
+			clock-output-names = "emac_tx";
+		};
+
 		dma: dma-controller at 01c02000 {
 			compatible = "allwinner,sun8i-h3-dma";
 			reg = <0x01c02000 0x1000>;
-- 
2.7.0
