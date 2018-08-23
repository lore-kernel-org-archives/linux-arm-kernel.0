From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 23 Aug 2018 15:22:46 +0100
Subject: [PATCH] arm64: dts: renesas: r8a774a1: Add CAN nodes
Message-ID: <1535034166-24798-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chris Paterson <chris.paterson2@renesas.com>

Add the device nodes for both RZ/G2M CAN channels.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
---

This patch depends on:
https://lkml.org/lkml/2018/8/23/1049
https://www.mail-archive.com/linux-renesas-soc at vger.kernel.org/msg30550.html


 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index 5d0109a..cd204f5 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -816,6 +816,30 @@
 			status = "disabled";
 		};
 
+		can0: can at e6c30000 {
+			compatible = "renesas,can-r8a774a1",
+				     "renesas,rzg-gen2-can";
+			reg = <0 0xe6c30000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 916>, <&can_clk>;
+			clock-names = "clkp1", "can_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 916>;
+			status = "disabled";
+		};
+
+		can1: can at e6c38000 {
+			compatible = "renesas,can-r8a774a1",
+				     "renesas,rzg-gen2-can";
+			reg = <0 0xe6c38000 0 0x1000>;
+			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 915>, <&can_clk>;
+			clock-names = "clkp1", "can_clk";
+			power-domains = <&sysc 32>;
+			resets = <&cpg 915>;
+			status = "disabled";
+		};
+
 		pwm0: pwm at e6e30000 {
 			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
 			reg = <0 0xe6e30000 0 0x8>;
-- 
2.7.4
