From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 31 Mar 2014 17:40:01 +0200
Subject: [PATCH 4/6] ARM: socfpga: dts: add can0+1
In-Reply-To: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396280404-2041-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add both can controllers to the dtsi.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d0594c3..51148b8 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -470,6 +470,22 @@
 			status = "disabled";
 		};
 
+		can0: can at 0xffc00000 {
+			compatible = "bosch,d_can";
+			reg = <0xffc00000 0x1000>;
+			interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
+			clocks = <&can0_clk>;
+			status = "disabled";
+		};
+
+		can1: can at 0xffc01000 {
+			compatible = "bosch,d_can";
+			reg = <0xffc01000 0x1000>;
+			interrupts = <0 135 4>, <0 136 4>, <0 137 4>, <0 138 4>;
+			clocks = <&can1_clk>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 0xffc04000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
