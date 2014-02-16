From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 16 Feb 2014 10:40:55 +0100
Subject: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
In-Reply-To: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 41194fe..5807b7a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -19,6 +19,15 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -170,6 +179,66 @@
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	i2c0: i2c at e6508000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
+		reg = <0 0xe6508000 0 0x40>;
+		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_I2C0>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at e6518000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
+		reg = <0 0xe6518000 0 0x40>;
+		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_I2C1>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_I2C2>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
+		reg = <0 0xe6540000 0 0x40>;
+		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_I2C3>;
+		status = "disabled";
+	};
+
+	i2c4: i2c at e6520000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
+		reg = <0 0xe6520000 0 0x40>;
+		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_I2C4>;
+		status = "disabled";
+	};
+
+	i2c5: i2c at e6528000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";
+		reg = <0 0xe6528000 0 0x40>;
+		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_I2C5>;
+		status = "disabled";
+	};
+
 	pfc: pfc at e6060000 {
 		compatible = "renesas,pfc-r8a7791";
 		reg = <0 0xe6060000 0 0x250>;
-- 
1.8.5.1
