From: rasmus.villemoes@prevas.dk (Rasmus Villemoes)
Date: Tue, 5 Dec 2017 09:12:47 +0100
Subject: [PATCH resend] arm: dts: ls1021a: add reboot node to .dtsi
In-Reply-To: <1510566980-26602-1-git-send-email-rasmus.villemoes@prevas.dk>
References: <1510566980-26602-1-git-send-email-rasmus.villemoes@prevas.dk>
Message-ID: <1512461568-12102-1-git-send-email-rasmus.villemoes@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LS1021A can be reset via the dcfg regmap in the same way as the
arm64 layerscape SoCs, so add the corresponding DT node.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 9319e1f0f1d8..3ff2b8a9f01a 100644
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
