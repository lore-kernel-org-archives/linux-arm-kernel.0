From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Fri,  7 Jun 2013 13:47:48 -0300
Subject: [PATCH 11/14] ARM: mvebu: Relocate Armada 370/XP DeviceBus device
 tree nodes
In-Reply-To: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1370623671-7748-12-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that mbus has been added to the device tree, it's possible to
move the DeviceBus out of internal registers, placing it directly
below the mbus. This is a more accurate representation of the hardware.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi             | 90 ++++++++++++------------
 arch/arm/boot/dts/armada-xp-gp.dts               | 58 +++++++--------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 58 +++++++--------
 3 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 68d9fa1..15b558a 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -34,6 +34,51 @@
 		compatible = "simple-bus";
 		interrupt-parent = <&mpic>;
 
+		devbus-bootcs {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0 0x10400 0x8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs0 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0 0x10408 0x8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs1 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0 0x10410 0x8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs2 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0 0x10418 0x8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
+		devbus-cs3 {
+			compatible = "marvell,mvebu-devbus";
+			reg = <0 0x10420 0x8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			clocks = <&coreclk 0>;
+			status = "disabled";
+		};
+
 		internal-regs {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -179,51 +224,6 @@
 				clocks = <&coreclk 0>;
 				status = "disabled";
 			};
-
-			devbus-bootcs at 10400 {
-				compatible = "marvell,mvebu-devbus";
-				reg = <0x10400 0x8>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			devbus-cs0 at 10408 {
-				compatible = "marvell,mvebu-devbus";
-				reg = <0x10408 0x8>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			devbus-cs1 at 10410 {
-				compatible = "marvell,mvebu-devbus";
-				reg = <0x10410 0x8>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			devbus-cs2 at 10418 {
-				compatible = "marvell,mvebu-devbus";
-				reg = <0x10418 0x8>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
-
-			devbus-cs3 at 10420 {
-				compatible = "marvell,mvebu-devbus";
-				reg = <0x10420 0x8>;
-				#address-cells = <1>;
-				#size-cells = <1>;
-				clocks = <&coreclk 0>;
-				status = "disabled";
-			};
 		};
 	};
  };
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 26ad06f..d045d6e 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -39,6 +39,35 @@
 	};
 
 	soc {
+		devbus-bootcs {
+			status = "okay";
+			ranges = <0 0x012f0000 0xf0000000 0x1000000>; /* @addr 0xf000000, size 0x1000000 */
+
+			/* Device Bus parameters are required */
+
+			/* Read parameters */
+			devbus,bus-width    = <8>;
+			devbus,turn-off-ps  = <60000>;
+			devbus,badr-skew-ps = <0>;
+			devbus,acc-first-ps = <124000>;
+			devbus,acc-next-ps  = <248000>;
+			devbus,rd-setup-ps  = <0>;
+			devbus,rd-hold-ps   = <0>;
+
+			/* Write parameters */
+			devbus,sync-enable = <0>;
+			devbus,wr-high-ps  = <60000>;
+			devbus,wr-low-ps   = <60000>;
+			devbus,ale-wr-ps   = <60000>;
+
+			/* NOR 16 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0x1000000>;
+				bank-width = <2>;
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
@@ -113,35 +142,6 @@
 				};
 			};
 
-			devbus-bootcs at 10400 {
-				status = "okay";
-				ranges = <0 0xf0000000 0x1000000>; /* @addr 0xf000000, size 0x1000000 */
-
-				/* Device Bus parameters are required */
-
-				/* Read parameters */
-				devbus,bus-width    = <8>;
-				devbus,turn-off-ps  = <60000>;
-				devbus,badr-skew-ps = <0>;
-				devbus,acc-first-ps = <124000>;
-				devbus,acc-next-ps  = <248000>;
-				devbus,rd-setup-ps  = <0>;
-				devbus,rd-hold-ps   = <0>;
-
-				/* Write parameters */
-				devbus,sync-enable = <0>;
-				devbus,wr-high-ps  = <60000>;
-				devbus,wr-low-ps   = <60000>;
-				devbus,ale-wr-ps   = <60000>;
-
-				/* NOR 16 MiB */
-				nor at 0 {
-					compatible = "cfi-flash";
-					reg = <0 0x1000000>;
-					bank-width = <2>;
-				};
-			};
-
 			pcie-controller {
 				status = "okay";
 
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index f14d36c..a895e1b 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -27,6 +27,35 @@
 	};
 
 	soc {
+		devbus-bootcs {
+			status = "okay";
+			ranges = <0 0x012f0000 0xf0000000 0x8000000>; /* @addr 0xf000000, size 0x8000000 */
+
+			/* Device Bus parameters are required */
+
+			/* Read parameters */
+			devbus,bus-width    = <8>;
+			devbus,turn-off-ps  = <60000>;
+			devbus,badr-skew-ps = <0>;
+			devbus,acc-first-ps = <124000>;
+			devbus,acc-next-ps  = <248000>;
+			devbus,rd-setup-ps  = <0>;
+			devbus,rd-hold-ps   = <0>;
+
+			/* Write parameters */
+			devbus,sync-enable = <0>;
+			devbus,wr-high-ps  = <60000>;
+			devbus,wr-low-ps   = <60000>;
+			devbus,ale-wr-ps   = <60000>;
+
+			/* NOR 128 MiB */
+			nor at 0 {
+				compatible = "cfi-flash";
+				reg = <0 0x8000000>;
+				bank-width = <2>;
+			};
+		};
+
 		internal-regs {
 			serial at 12000 {
 				clock-frequency = <250000000>;
@@ -141,35 +170,6 @@
 				status = "okay";
 			};
 
-			devbus-bootcs at 10400 {
-				status = "okay";
-				ranges = <0 0xf0000000 0x8000000>; /* @addr 0xf000000, size 0x8000000 */
-
-				/* Device Bus parameters are required */
-
-				/* Read parameters */
-				devbus,bus-width    = <8>;
-				devbus,turn-off-ps  = <60000>;
-				devbus,badr-skew-ps = <0>;
-				devbus,acc-first-ps = <124000>;
-				devbus,acc-next-ps  = <248000>;
-				devbus,rd-setup-ps  = <0>;
-				devbus,rd-hold-ps   = <0>;
-
-				/* Write parameters */
-				devbus,sync-enable = <0>;
-				devbus,wr-high-ps  = <60000>;
-				devbus,wr-low-ps   = <60000>;
-				devbus,ale-wr-ps   = <60000>;
-
-				/* NOR 128 MiB */
-				nor at 0 {
-					compatible = "cfi-flash";
-					reg = <0 0x8000000>;
-					bank-width = <2>;
-				};
-			};
-
 			pcie-controller {
 				status = "okay";
 				/* Internal mini-PCIe connector */
-- 
1.8.1.5
