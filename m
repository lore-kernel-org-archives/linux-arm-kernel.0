From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Mon, 13 Nov 2017 10:56:20 +0100
Subject: [PATCH] arm: dts: ls1021a: add reboot node to .dtsi
Message-ID: <1510566980-26602-1-git-send-email-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LS1021A can be reset via the dcfg regmap in the same way as the
arm64 layerscape SoCs, so add the corresponding DT node.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f..3ff2b8a 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -108,6 +108,13 @@
 			     <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	reboot {
+		compatible = "syscon-reboot";
+		regmap = <&dcfg>;
+		offset = <0xb0>;
+		mask = <0x02>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.7.4
