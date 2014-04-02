From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed,  2 Apr 2014 09:11:38 +0200
Subject: [PATCH v2 4/6] ARM: socfpga: dts: add can0+1
In-Reply-To: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396422700-3962-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396422700-3962-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add both can controllers to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Changes since v1:
	- correct node naming scheme

 arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 292c3b2..c8ced33 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -470,6 +470,22 @@
 			status = "disabled";
 		};
 
+		can0: can at ffc00000 {
+			compatible = "bosch,d_can";
+			reg = <0xffc00000 0x1000>;
+			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
+			clocks = <&can0_clk>;
+			status = "disabled";
+		};
+
+		can1: can at ffc01000 {
+			compatible = "bosch,d_can";
+			reg = <0xffc01000 0x1000>;
+			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
+			clocks = <&can1_clk>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at ffc04000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
