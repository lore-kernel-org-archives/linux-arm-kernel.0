From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  5 Apr 2016 00:22:33 +0800
Subject: [PATCH RFC 4/5] ARM: dts: sun8i-h3: Add Ethernet controller device
 node to sun8i-h3.dtsi
In-Reply-To: <1459786954-12649-1-git-send-email-wens@csie.org>
References: <1459786954-12649-1-git-send-email-wens@csie.org>
Message-ID: <1459786954-12649-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: LABBE Corentin <clabbe.montjoie@gmail.com>

The Allwinner H3 SoC has a gigabit Ethernet controller.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
[wens at csie.org: drop pinmux; update clocks/resets]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

This is not a stable binding. Do not merge.

---
 arch/arm/boot/dts/sun8i-h3.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 9a28aeba9bc6..7749af6354bb 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -635,6 +635,18 @@
 			status = "disabled";
 		};
 
+		emac: ethernet at 1c30000 {
+			compatible = "allwinner,sun8i-h3-emac";
+			reg = <0x01c30000 0x1000>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&ahb_rst 17>;
+			reset-names = "ahb";
+			clocks = <&bus_gates 17>, <&ephy>;
+			clock-names = "ahb", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
2.7.0
