From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:36:55 +0900
Subject: [PATCH 01/19] ARM: shmobile: r8a73a4: Add pin control device to
 device tree
In-Reply-To: <cover.1374208262.git.horms+renesas@verge.net.au>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
Message-ID: <c173e780f82e5dea3da21f9eda47bc48aa3f57b1.1374208262.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add a pfc node to the r8a73a4 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi |   88 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4ff2019..f1a35d5 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -85,4 +85,92 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 4>;
 	};
+
+	i2c0: i2c at e6500000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6500000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 174 0x4>;
+	};
+
+	i2c1: i2c at e6510000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6510000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 175 0x4>;
+	};
+
+	i2c2: i2c at e6520000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6520000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 176 0x4>;
+	};
+
+	i2c3: i2c at e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6530000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 177 0x4>;
+	};
+
+	i2c4: i2c at e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6540000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 178 0x4>;
+	};
+
+	i2c5: i2c at e60b0000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe60b0000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 179 0x4>;
+	};
+
+	i2c6: i2c at e6550000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6550000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 184 0x4>;
+	};
+
+	i2c7: i2c at e6560000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6560000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 185 0x4>;
+	};
+
+	i2c8: i2c at e6570000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,rmobile-iic";
+		reg = <0 0xe6570000 0 0x428>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 173 0x4>;
+	};
+
+	pfc: pfc at e6050000 {
+		compatible = "renesas,pfc-r8a73a4";
+		reg = <0xe6050000 0x9000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.7.10.4
