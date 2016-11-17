From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:05:03 +0100
Subject: [PATCH v3 14/19] ARM: dts: armada-370-xp: Fixup internal-regs DT
 warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-15-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

internal-regs has a ranges property so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts                          | 6 +++++-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts               | 6 +++++-
 arch/arm/boot/dts/armada-370-mirabox.dts                     | 6 +++++-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts               | 6 +++++-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts               | 6 +++++-
 arch/arm/boot/dts/armada-370-rd.dts                          | 6 +++++-
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts            | 6 +++++-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi           | 6 +++++-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts | 6 +++++-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts      | 6 +++++-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi     | 6 +++++-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts             | 6 +++++-
 arch/arm/boot/dts/armada-370-xp.dtsi                         | 6 +++++-
 arch/arm/boot/dts/armada-370.dtsi                            | 6 +++++-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                    | 6 +++++-
 arch/arm/boot/dts/armada-xp-db.dts                           | 6 +++++-
 arch/arm/boot/dts/armada-xp-gp.dts                           | 6 +++++-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts              | 6 +++++-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts                | 6 +++++-
 arch/arm/boot/dts/armada-xp-matrix.dts                       | 6 +++++-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi                     | 6 +++++-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi                     | 6 +++++-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi                     | 6 +++++-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts               | 6 +++++-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts             | 6 +++++-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts               | 6 +++++-
 arch/arm/boot/dts/armada-xp.dtsi                             | 6 +++++-
 27 files changed, 135 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index f3adc187c6a5..6544be190550 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -77,7 +77,11 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index 9e499eeede4b..712799b85031 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -72,7 +72,11 @@
 			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			sata at a0000 {
 				nr-ports = <2>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index c4dded0cd0c1..94131595973f 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -64,7 +64,11 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 99b9d73ebbaf..9941a6fdf2f5 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -66,7 +66,11 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index b5dd30178725..d9203b79c3d3 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -66,7 +66,11 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 29722b9f288e..a5fc93b2da8d 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -77,7 +77,11 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index eb6af53b4954..0d11e07c9c2e 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -28,7 +28,11 @@
 	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			ethernet at 74000 {
 				status = "okay";
 				pinctrl-0 = <&ge1_rgmii_pins>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 9b582c47f10c..34b745325689 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -32,7 +32,11 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
index 3c91f9821c89..c659a9085549 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -27,7 +27,11 @@
 	compatible = "seagate,cumulus-max", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			sata at a0000 {
 				status = "okay";
 				nr-ports = <2>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
index aad39e97af43..175b6459745b 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -27,7 +27,11 @@
 	compatible = "seagate,cumulus", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			sata at a0000 {
 				status = "okay";
 				nr-ports = <1>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index bb678a45ac8e..b00427d605ed 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -33,7 +33,11 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			coherency-fabric at 20200 {
 				broken-idle;
 			};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index a696bbf0f703..d0b0341c8fc8 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -80,7 +80,11 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 
 			/* RTC provided by Seiko S-35390A I2C RTC chip below */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 266d9c5853b5..85d6b4b30014 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -139,7 +139,11 @@
 			status = "disabled";
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 0308783fa89a..c07f584ab812 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -130,7 +130,11 @@
 			};
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			L2: l2-cache at 8000 {
 				compatible = "marvell,aurora-outer-cache";
 				reg = <0x08000 0x1000>;
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index d12b06bf0d60..b3c7e236f492 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -73,7 +73,11 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			/* UART0 */
 			serial at 12000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 607ce1f2ddd6..0656ff44b563 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -80,7 +80,11 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 015b8ab722a5..eb935a230531 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -99,7 +99,11 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 1dce74d9b616..8904864848a4 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -68,7 +68,11 @@
 			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 488a047481d4..0aa5ef30a088 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -73,7 +73,11 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 
 			rtc at 10300 {
 				/* No crystal connected to the internal RTC */
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 8b5a4e79d26b..0b4a401c16ab 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -71,7 +71,11 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 05c164b5786d..8fa9b73befa6 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -200,7 +200,11 @@
 			};
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 07894b0d3e59..3eab76ef2448 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -283,7 +283,11 @@
 			};
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 775bee53ce86..7fefd1fe1eef 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -321,7 +321,11 @@
 			};
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 5aaaf0fb2330..7a0e81d2ae68 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -67,7 +67,11 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index e40f3314b699..468d850ff9b7 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -70,7 +70,11 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xd1200000 0x100000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			rtc at 10300 {
 				/* No crystal connected to the internal RTC */
 				status = "disabled";
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index d5630a7b4b18..89ab42010a6c 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -81,7 +81,11 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 
 			/* RTC is provided by Seiko S-35390A below */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index fddec79a9832..68db324d6912 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -76,7 +76,11 @@
 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
 		};
 
-		internal-regs {
+		/* The following unit address is composed of the target
+		 * value (bit [40-47]), attributes value (bits [32-39],
+		 * and the address value in the window memory: [0-31].
+		 */
+		internal-regs at f00100000000 {
 			sdramc at 1400 {
 				compatible = "marvell,armada-xp-sdram-controller";
 				reg = <0x1400 0x500>;
-- 
2.10.2
