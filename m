From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:12 +0900
Subject: [PATCH 02/13] ARM: shmobile: r8a7790: add I2C DT nodes
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <edd2b9f4e6ed39032ffe9793e262c8a4b62c2152.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Add DT nodes for the four I2C interfacces on r8a7790.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a0cfb661..47bc1cb 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -176,6 +176,46 @@
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
 
+	i2c0: i2c at e6508000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6508000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 287 0x4>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at e6518000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6518000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 288 0x4>;
+		status = "disabled";
+	};
+
+	i2c2: i2c at e6530000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6530000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 286 0x4>;
+		status = "disabled";
+	};
+
+	i2c3: i2c at e6540000 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "renesas,i2c-r8a7790";
+		reg = <0 0xe6540000 0 0x40>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 290 0x4>;
+		status = "disabled";
+	};
+
 	mmcif0: mmcif at ee200000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-- 
1.8.4
