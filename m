From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Dec 2015 11:52:39 +0900
Subject: [PATCH/RFC 02/19] ARM: shmobile: r8a7793: add i2c to device tree
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1449802376-11301-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instantiate i2c controllers in r8a7793 device tree.

Based on similar work for the r8a7791 and r8a7791 by Wolfram Sang.

Cc: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793.dtsi | 73 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793.dtsi b/arch/arm/boot/dts/r8a7793.dtsi
index e7f6e9bd13d6..b8998b9519f6 100644
--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -19,6 +19,12 @@
 	#size-cells = <2>;
 
 	aliases {
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c4;
+		i2c5 = &i2c5;
 		spi0 = &qspi;
 	};
 
@@ -297,6 +303,73 @@
 		dma-channels = <15>;
 	};
 
+	i2c0: i2c at e6508000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6508000 0 0x40>;
+		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C0>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at e6518000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6518000 0 0x40>;
+		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C1>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C2>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6540000 0 0x40>;
+		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C3>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	i2c4: i2c at e6520000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6520000 0 0x40>;
+		interrupts = <0 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C4>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
+	i2c5: i2c at e6528000 {
+		/* doesn't need pinmux */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7793";
+		reg = <0 0xe6528000 0 0x40>;
+		interrupts = <0 20 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7793_CLK_I2C5>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+	};
+
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7793", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-- 
2.1.4
