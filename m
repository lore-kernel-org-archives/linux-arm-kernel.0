From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 10 Mar 2014 12:26:58 +0100
Subject: [PATCH V2 3/5] ARM: shmobile: r8a7791: add IIC(B) cores to dtsi
In-Reply-To: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
References: <1394450820-8158-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1394450820-8158-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---

Changes since V1: use better compatible name "renesas,iic-r8a7791"

 arch/arm/boot/dts/r8a7791.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 858a8a923b00..f71670a5bfbc 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -27,6 +27,9 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		i2c6 = &i2c6;
+		i2c7 = &i2c7;
+		i2c8 = &i2c8;
 		spi0 = &qspi;
 		spi1 = &msiof0;
 		spi2 = &msiof1;
@@ -184,6 +187,7 @@
 			     <0 17 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	/* The memory map in the User's Manual maps the cores to bus numbers */
 	i2c0: i2c at e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -235,6 +239,7 @@
 	};
 
 	i2c5: i2c at e6528000 {
+		/* doesn't need pinmux */
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7791";
@@ -244,6 +249,37 @@
 		status = "disabled";
 	};
 
+	i2c6: i2c at e60b0000 {
+		/* doesn't need pinmux */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x425>;
+		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
+		status = "disabled";
+	};
+
+	i2c7: i2c at e6500000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x425>;
+		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
+		status = "disabled";
+	};
+
+	i2c8: i2c at e6510000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,iic-r8a7791", "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x425>;
+		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
+		status = "disabled";
+	};
+
 	pfc: pfc at e6060000 {
 		compatible = "renesas,pfc-r8a7791";
 		reg = <0 0xe6060000 0 0x250>;
-- 
1.9.0
