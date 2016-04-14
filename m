From: brian.starkey@arm.com (Brian Starkey)
Date: Thu, 14 Apr 2016 10:52:26 +0100
Subject: [PATCH v2] ARM: arm64: dts: Add expansion bus to VExpress and Juno
Message-ID: <1460627546-24230-1-git-send-email-brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VExpress and Juno development platforms have an external expansion
bus which can be used for additional hardware (e.g. LogicTile Express
daughterboards).
Add this bus to all VExpress CoreTile and Juno device-trees.

On VExpress, the bus is described for a CoreTile occupying site 1.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
---

Only change from v1 is rewording of the commit message as suggested
by Liviu.

 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |   13 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |   13 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |   13 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      |   13 +++++++++++++
 arch/arm64/boot/dts/arm/juno-base.dtsi      |   10 ++++++++++
 5 files changed, 62 insertions(+)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
index 9420053..ec7539b 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts
@@ -280,4 +280,17 @@
 
 		/include/ "vexpress-v2m-rs1.dtsi"
 	};
+
+	site2: hsb at 40000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x40000000 0x3fef0000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 3>;
+		interrupt-map = <0 0 &gic 0 36 4>,
+				<0 1 &gic 0 37 4>,
+				<0 2 &gic 0 38 4>,
+				<0 3 &gic 0 39 4>;
+	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index 17f63f7..a339b0c 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -638,4 +638,17 @@
 
 		/include/ "vexpress-v2m-rs1.dtsi"
 	};
+
+	site2: hsb at 40000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x40000000 0x3fef0000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 3>;
+		interrupt-map = <0 0 &gic 0 36 4>,
+				<0 1 &gic 0 37 4>,
+				<0 2 &gic 0 38 4>,
+				<0 3 &gic 0 39 4>;
+	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
index d2709b7..76a9ccb 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca5s.dts
@@ -250,4 +250,17 @@
 
 		/include/ "vexpress-v2m-rs1.dtsi"
 	};
+
+	site2: hsb at 40000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x40000000 0x40000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 3>;
+		interrupt-map = <0 0 &gic 0 36 4>,
+				<0 1 &gic 0 37 4>,
+				<0 2 &gic 0 38 4>,
+				<0 3 &gic 0 39 4>;
+	};
 };
diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
index d949fac..edac212 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
@@ -359,4 +359,17 @@
 
 		/include/ "vexpress-v2m.dtsi"
 	};
+
+	site2: hsb at e0000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0xe0000000 0x20000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 3>;
+		interrupt-map = <0 0 &gic 0 36 4>,
+				<0 1 &gic 0 37 4>,
+				<0 2 &gic 0 38 4>,
+				<0 3 &gic 0 39 4>;
+	};
 };
diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 68ccc39..dee2386 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -272,3 +272,13 @@
 
 		/include/ "juno-motherboard.dtsi"
 	};
+
+	site2: tlx at 60000000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x60000000 0x10000000>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0>;
+		interrupt-map = <0 0 &gic 0 0 0 168 IRQ_TYPE_LEVEL_HIGH>;
+	};
-- 
1.7.9.5
