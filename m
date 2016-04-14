From: brian.starkey@arm.com (Brian Starkey)
Date: Thu, 14 Apr 2016 16:39:18 +0100
Subject: [PATCH v3 1/2] ARM: dts: Add expansion bus to VExpress
Message-ID: <1460648359-7310-1-git-send-email-brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VExpress development platform has an external expansion bus which
can be used for additional hardware (e.g. LogicTile Express
daughterboards).
Add this bus to the VExpress CoreTile device-trees.

The bus is described for a CoreTile occupying site 1.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>
---

Changes since v2:
 - Split into ARM and arm64 patches (Sudeep)

Changes since v1:
 - Reword commit message (Liviu)

 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts |   13 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts  |   13 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts     |   13 +++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts      |   13 +++++++++++++
 4 files changed, 52 insertions(+)

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
-- 
1.7.9.5
