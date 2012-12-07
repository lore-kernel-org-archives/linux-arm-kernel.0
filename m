From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  7 Dec 2012 23:04:34 +0100
Subject: [RFC v1 11/16] arm: mvebu: add PCIe Device Tree informations for
 Armada XP
In-Reply-To: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1354917879-32073-12-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP SoCs have multiple PCIe interfaces. The MV78230 has 2
PCIe units (one 4x or quad 1x, the other 1x only), the MV78260 has 3
PCIe units (two 4x or quad 1x and one 4x/1x), the MV78460 has 4 PCIe
units (two 4x or quad 1x and two 4x/1x). We therefore add the
necessary Device Tree informations to make those PCIe interfaces
usable.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |   62 +++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi |   72 +++++++++++++++++++
 arch/arm/boot/dts/armada-xp-mv78460.dtsi |  112 ++++++++++++++++++++++++++++++
 3 files changed, 246 insertions(+)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index c45c7b4..a4c4fca 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -65,5 +65,67 @@
 			#interrupts-cells = <2>;
 			interrupts = <20>, <21>, <22>;
 		};
+
+		/*
+		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
+		 * configured as x4 or quad x1 lanes. One unit is
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0       0xd0040000 0x2000 /* port0x1_port0 */
+				  0x2000  0xd0042000 0x2000 /* port2x1_port0 */
+				  0x4000  0xd0044000 0x2000 /* port0x1_port1 */
+				  0x8000  0xd0048000 0x2000 /* port0x1_port2 */
+				  0xC000  0xd004C000 0x2000 /* port0x1_port3 */>;
+
+			pcie0.0 at 0xd0040000 {
+				reg = <0x0 0x2000>;
+				interrupts = <58>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+
+			pcie0.1 at 0xd0044000 {
+				reg = <0x4000 0x2000>;
+				interrupts = <59>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				status = "disabled";
+			};
+
+			pcie0.2 at 0xd0048000 {
+				reg = <0x8000 0x2000>;
+				interrupts = <60>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				status = "disabled";
+			};
+
+			pcie0.3 at 0xd004C000 {
+				reg = <0xC000 0x2000>;
+				interrupts = <61>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				status = "disabled";
+			};
+
+			pcie2 at 0xd0042000 {
+				reg = <0x2000 0x2000>;
+				interrupts = <99>;
+				clocks = <&gateclk 7>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index a2aee57..d799a29 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -85,5 +85,77 @@
 			#interrupts-cells = <2>;
 			interrupts = <24>;
 		};
+
+		/*
+		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
+		 * configured as x4 or quad x1 lanes. One unit is
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "okay";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0       0xd0040000 0x2000 /* port0x1_port0 */
+				  0x2000  0xd0042000 0x2000 /* port2x1_port0 */
+				  0x4000  0xd0044000 0x2000 /* port0x1_port1 */
+				  0x8000  0xd0048000 0x2000 /* port0x1_port2 */
+				  0xC000  0xd004C000 0x2000 /* port0x1_port3 */
+				  0x12000 0xd0082000 0x2000 /* port3x1_port0 */>;
+
+			pcie0.0 at 0xd0040000 {
+				reg = <0x0 0x2000>;
+				interrupts = <58>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+
+			pcie0.1 at 0xd0044000 {
+				reg = <0x4000 0x2000>;
+				interrupts = <59>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				status = "disabled";
+			};
+
+			pcie0.2 at 0xd0048000 {
+				reg = <0x8000 0x2000>;
+				interrupts = <60>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				status = "disabled";
+			};
+
+			pcie0.3 at 0xd004C000 {
+				reg = <0xC000 0x2000>;
+				interrupts = <61>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				status = "disabled";
+			};
+
+			pcie2 at 0xd0042000 {
+				reg = <0x2000 0x2000>;
+				interrupts = <99>;
+				clocks = <&gateclk 7>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+
+			pcie3 at 0xd0082000 {
+				reg = <0x12000 0x2000>;
+				interrupts = <103>;
+				clocks = <&gateclk 8>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index da03a12..c2579d7 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -100,5 +100,117 @@
 			#interrupts-cells = <2>;
 			interrupts = <24>;
 		};
+
+		/*
+		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
+		 * configured as x4 or quad x1 lanes. Two units are
+		 * x4/x1.
+		 */
+		pcie-controller {
+			compatible = "marvell,armada-370-xp-pcie";
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0       0xd0040000 0x2000 /* port0x1_port0 */
+				  0x2000  0xd0042000 0x2000 /* port2x1_port0 */
+				  0x4000  0xd0044000 0x2000 /* port0x1_port1 */
+				  0x8000  0xd0048000 0x2000 /* port0x1_port2 */
+				  0xC000  0xd004C000 0x2000 /* port0x1_port3 */
+				  0x10000 0xd0080000 0x2000 /* port1x1_port0 */
+				  0x12000 0xd0082000 0x2000 /* port3x1_port0 */
+				  0x14000 0xd0084000 0x2000 /* port1x1_port1 */
+				  0x18000 0xd0088000 0x2000 /* port1x1_port2 */
+				  0x1C000 0xd008C000 0x2000 /* port1x1_port3 */>;
+
+			pcie0.0 at 0xd0040000 {
+				reg = <0x0 0x2000>;
+				interrupts = <58>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+
+			pcie0.1 at 0xd0044000 {
+				reg = <0x4000 0x2000>;
+				interrupts = <59>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <1>;
+				status = "disabled";
+			};
+
+			pcie0.2 at 0xd0048000 {
+				reg = <0x8000 0x2000>;
+				interrupts = <60>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <2>;
+				status = "disabled";
+			};
+
+			pcie0.3 at 0xd004C000 {
+				reg = <0xC000 0x2000>;
+				interrupts = <61>;
+				clocks = <&gateclk 5>;
+				marvell,pcie-port = <0>;
+				marvell,pcie-lane = <3>;
+				status = "disabled";
+			};
+
+			pcie1.0 at 0xd0040000 {
+				reg = <0x10000 0x2000>;
+				interrupts = <62>;
+				clocks = <&gateclk 6>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+
+			pcie1.1 at 0xd0044000 {
+				reg = <0x14000 0x2000>;
+				interrupts = <63>;
+				clocks = <&gateclk 6>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <1>;
+				status = "disabled";
+			};
+
+			pcie1.2 at 0xd0048000 {
+				reg = <0x18000 0x2000>;
+				interrupts = <64>;
+				clocks = <&gateclk 6>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <2>;
+				status = "disabled";
+			};
+
+			pcie1.3 at 0xd004C000 {
+				reg = <0x1C000 0x2000>;
+				interrupts = <65>;
+				clocks = <&gateclk 6>;
+				marvell,pcie-port = <1>;
+				marvell,pcie-lane = <3>;
+				status = "disabled";
+			};
+
+			pcie2 at 0xd0042000 {
+				reg = <0x2000 0x2000>;
+				interrupts = <99>;
+				clocks = <&gateclk 7>;
+				marvell,pcie-port = <2>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+
+			pcie3 at 0xd0082000 {
+				reg = <0x12000 0x2000>;
+				interrupts = <103>;
+				clocks = <&gateclk 8>;
+				marvell,pcie-port = <3>;
+				marvell,pcie-lane = <0>;
+				status = "disabled";
+			};
+		};
 	};
  };
-- 
1.7.9.5
