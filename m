From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:50:11 +0900
Subject: [PATCH 01/13] ARM: shmobile: only enable used I2C interfaces in DT on
 all Renesas boards
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
Message-ID: <eda3a4fa9529341f2ce23374e5f295764d0b5838.1381298964.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Currently all I2C interfaces in all *.dtsi files for various Renesas SoCs
are enabled by default. Switch them all off and only enable populated I2C
interfaces in board-specific *.dts files.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts         | 1 +
 arch/arm/boot/dts/r8a73a4-ape6evm.dts                   | 1 +
 arch/arm/boot/dts/r8a73a4.dtsi                          | 9 +++++++++
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 1 +
 arch/arm/boot/dts/r8a7740.dtsi                          | 2 ++
 arch/arm/boot/dts/r8a7779.dtsi                          | 4 ++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts            | 2 ++
 arch/arm/boot/dts/sh73a0.dtsi                           | 5 +++++
 8 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 2b49b05..9443e93 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -62,6 +62,7 @@
 };
 
 &i2c5 {
+	status = "okay";
 	vdd_dvfs: max8973 at 1b {
 		compatible = "maxim,max8973";
 		reg = <0x1b>;
diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 72f867e..91436b5 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -52,6 +52,7 @@
 };
 
 &i2c5 {
+	status = "okay";
 	vdd_dvfs: max8973 at 1b {
 		compatible = "maxim,max8973";
 		reg = <0x1b>;
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6c26caa..a2c9456 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -93,6 +93,7 @@
 		reg = <0 0xe6500000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 174 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c at e6510000 {
@@ -102,6 +103,7 @@
 		reg = <0 0xe6510000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 175 0x4>;
+		status = "disabled";
 	};
 
 	i2c2: i2c at e6520000 {
@@ -111,6 +113,7 @@
 		reg = <0 0xe6520000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 176 0x4>;
+		status = "disabled";
 	};
 
 	i2c3: i2c at e6530000 {
@@ -120,6 +123,7 @@
 		reg = <0 0xe6530000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 177 0x4>;
+		status = "disabled";
 	};
 
 	i2c4: i2c at e6540000 {
@@ -129,6 +133,7 @@
 		reg = <0 0xe6540000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 178 0x4>;
+		status = "disabled";
 	};
 
 	i2c5: i2c at e60b0000 {
@@ -138,6 +143,7 @@
 		reg = <0 0xe60b0000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 179 0x4>;
+		status = "disabled";
 	};
 
 	i2c6: i2c at e6550000 {
@@ -147,6 +153,7 @@
 		reg = <0 0xe6550000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 184 0x4>;
+		status = "disabled";
 	};
 
 	i2c7: i2c at e6560000 {
@@ -156,6 +163,7 @@
 		reg = <0 0xe6560000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 185 0x4>;
+		status = "disabled";
 	};
 
 	i2c8: i2c at e6570000 {
@@ -165,6 +173,7 @@
 		reg = <0 0xe6570000 0 0x428>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 173 0x4>;
+		status = "disabled";
 	};
 
 	mmcif0: mmcif at ee200000 {
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index c638e4a..9fcffc1 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -52,6 +52,7 @@
 };
 
 &i2c0 {
+	status = "okay";
 	touchscreen: st1232 at 55 {
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 44d3d52..868bdde 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -131,6 +131,7 @@
 			      0 202 0x4
 			      0 203 0x4
 			      0 204 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c at e6c20000 {
@@ -143,6 +144,7 @@
 			      0 71 0x4
 			      0 72 0x4
 			      0 73 0x4>;
+		status = "disabled";
 	};
 
 	pfc: pfc at e6050000 {
diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 23a6244..65dc652 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -156,6 +156,7 @@
 		reg = <0xffc70000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 79 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c at ffc71000 {
@@ -165,6 +166,7 @@
 		reg = <0xffc71000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 82 0x4>;
+		status = "disabled";
 	};
 
 	i2c2: i2c at ffc72000 {
@@ -174,6 +176,7 @@
 		reg = <0xffc72000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 80 0x4>;
+		status = "disabled";
 	};
 
 	i2c3: i2c at ffc73000 {
@@ -183,6 +186,7 @@
 		reg = <0xffc73000 0x1000>;
 		interrupt-parent = <&gic>;
 		interrupts = <0 81 0x4>;
+		status = "disabled";
 	};
 
 	pfc: pfc at fffc0000 {
diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 2122306..8ee06dd 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -108,6 +108,7 @@
 };
 
 &i2c0 {
+	status = "okay";
 	as3711 at 40 {
 		compatible = "ams,as3711";
 		reg = <0x40>;
@@ -183,6 +184,7 @@
 &i2c3 {
 	pinctrl-0 = <&i2c3_pins>;
 	pinctrl-names = "default";
+	status = "okay";
 };
 
 &mmcif {
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ba59a58..f56665a 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -135,6 +135,7 @@
 			      0 168 0x4
 			      0 169 0x4
 			      0 170 0x4>;
+		status = "disabled";
 	};
 
 	i2c1: i2c at e6822000 {
@@ -147,6 +148,7 @@
 			      0 52 0x4
 			      0 53 0x4
 			      0 54 0x4>;
+		status = "disabled";
 	};
 
 	i2c2: i2c at e6824000 {
@@ -159,6 +161,7 @@
 			      0 172 0x4
 			      0 173 0x4
 			      0 174 0x4>;
+		status = "disabled";
 	};
 
 	i2c3: i2c at e6826000 {
@@ -171,6 +174,7 @@
 			      0 184 0x4
 			      0 185 0x4
 			      0 186 0x4>;
+		status = "disabled";
 	};
 
 	i2c4: i2c at e6828000 {
@@ -183,6 +187,7 @@
 			      0 188 0x4
 			      0 189 0x4
 			      0 190 0x4>;
+		status = "disabled";
 	};
 
 	mmcif: mmcif at e6bd0000 {
-- 
1.8.4
