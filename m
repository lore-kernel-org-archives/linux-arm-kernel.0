From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon, 31 Mar 2014 17:40:00 +0200
Subject: [PATCH 3/6] ARM: socfpga: dts: add i2c busses
In-Reply-To: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1396280404-2041-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1396280404-2041-3-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add all 4 i2c busses.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 7867e7f..d0594c3 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -470,6 +470,50 @@
 			status = "disabled";
 		};
 
+		i2c0: i2c at 0xffc04000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc04000 0x1000>;
+			clock-frequency = <400000000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 158 0x4>;
+			status = "disabled";
+		};
+
+		i2c1: i2c at 0xffc05000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc05000 0x1000>;
+			clock-frequency = <100000000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 159 0x4>;
+			status = "disabled";
+		};
+
+		i2c2: i2c at 0xffc06000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc06000 0x1000>;
+			clock-frequency = <100000000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 160 0x4>;
+			status = "disabled";
+		};
+
+		i2c3: i2c at 0xffc07000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "snps,designware-i2c";
+			reg = <0xffc07000 0x1000>;
+			clock-frequency = <100000000>;
+			clocks = <&l4_sp_clk>;
+			interrupts = <0 161 0x4>;
+			status = "disabled";
+		};
+
 		L2: l2-cache at fffef000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffef000 0x1000>;
-- 
1.9.1
