From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:23:57 +0100
Subject: [PATCH v2 14/19] ARM: dts: armada-370-xp: Fixup internal-regs DT
 warning
In-Reply-To: <20161113212402.3060-1-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
Message-ID: <20161113212402.3060-15-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

internal-regs has a ranges property so the unit name should contain an
address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-370-db.dts                          | 2 +-
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts               | 2 +-
 arch/arm/boot/dts/armada-370-mirabox.dts                     | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts               | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts               | 2 +-
 arch/arm/boot/dts/armada-370-rd.dts                          | 2 +-
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts            | 2 +-
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi           | 2 +-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts | 2 +-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts      | 2 +-
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi     | 2 +-
 arch/arm/boot/dts/armada-370-synology-ds213j.dts             | 2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi                         | 2 +-
 arch/arm/boot/dts/armada-370.dtsi                            | 2 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts                    | 2 +-
 arch/arm/boot/dts/armada-xp-db.dts                           | 2 +-
 arch/arm/boot/dts/armada-xp-gp.dts                           | 2 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts              | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts                | 2 +-
 arch/arm/boot/dts/armada-xp-matrix.dts                       | 2 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi                     | 2 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi                     | 2 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi                     | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts               | 2 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts             | 2 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts               | 2 +-
 arch/arm/boot/dts/armada-xp.dtsi                             | 2 +-
 27 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
index f3adc187c6a5..6ab09c846211 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -77,7 +77,7 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index 9e499eeede4b..ee114f920494 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -72,7 +72,7 @@
 			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			sata at a0000 {
 				nr-ports = <2>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index c4dded0cd0c1..3ee6228c1dd6 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -64,7 +64,7 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 99b9d73ebbaf..6b2437fa8e84 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -66,7 +66,7 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index b5dd30178725..2ed97b8ae686 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -66,7 +66,7 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 29722b9f288e..f2535794d35b 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -77,7 +77,7 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index eb6af53b4954..61a3576ca090 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -28,7 +28,7 @@
 	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		internal-regs {
+		internal-regs at f0_01_0 {
 			ethernet at 74000 {
 				status = "okay";
 				pinctrl-0 = <&ge1_rgmii_pins>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 9b582c47f10c..64a1ccfda42b 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -32,7 +32,7 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
index 3c91f9821c89..0ba79c0cf379 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -27,7 +27,7 @@
 	compatible = "seagate,cumulus-max", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		internal-regs {
+		internal-regs at f0_01_0 {
 			sata at a0000 {
 				status = "okay";
 				nr-ports = <2>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
index aad39e97af43..1766f74ffa7d 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -27,7 +27,7 @@
 	compatible = "seagate,cumulus", "marvell,armada370", "marvell,armada-370-xp";
 
 	soc {
-		internal-regs {
+		internal-regs at f0_01_0 {
 			sata at a0000 {
 				status = "okay";
 				nr-ports = <1>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index bb678a45ac8e..0b25f1dac938 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -33,7 +33,7 @@
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			coherency-fabric at 20200 {
 				broken-idle;
 			};
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index a696bbf0f703..f4b6f5fca85c 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -80,7 +80,7 @@
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 
 			/* RTC provided by Seiko S-35390A I2C RTC chip below */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 728b7aa5e6fd..5505b14c2ac4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -134,7 +134,7 @@
 			status = "disabled";
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			compatible = "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index f7f7194c30c8..9b73bd924424 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -126,7 +126,7 @@
 			};
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			L2: l2-cache at 8000 {
 				compatible = "marvell,aurora-outer-cache";
 				reg = <0x08000 0x1000>;
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index d12b06bf0d60..9c569796301b 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -73,7 +73,7 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			/* UART0 */
 			serial at 12000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 607ce1f2ddd6..3dd6756e86af 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -80,7 +80,7 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 015b8ab722a5..a5469e23dd85 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -99,7 +99,7 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xf1200000 0x100000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 1dce74d9b616..a1343f9cbb0e 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -68,7 +68,7 @@
 			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 488a047481d4..738e5d5b9d1a 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -73,7 +73,7 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 
 			rtc at 10300 {
 				/* No crystal connected to the internal RTC */
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 8b5a4e79d26b..7a5c9d1a2caa 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -71,7 +71,7 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			serial at 12000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 05c164b5786d..64a80419e284 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -200,7 +200,7 @@
 			};
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 07894b0d3e59..acdd9152c232 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -283,7 +283,7 @@
 			};
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 775bee53ce86..53982474344f 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -321,7 +321,7 @@
 			};
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			gpio0: gpio at 18100 {
 				compatible = "marvell,orion-gpio";
 				reg = <0x18100 0x40>;
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 5aaaf0fb2330..e6e009dda98f 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -67,7 +67,7 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 
 			/* RTC is provided by Intersil ISL12057 I2C RTC chip */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index e40f3314b699..308e2547d46e 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -70,7 +70,7 @@
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000
 			  MBUS_ID(0x0c, 0x04) 0 0 0xd1200000 0x100000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			rtc at 10300 {
 				/* No crystal connected to the internal RTC */
 				status = "disabled";
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index d5630a7b4b18..fb553d462b5a 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -81,7 +81,7 @@
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
 			  MBUS_ID(0x09, 0x05) 0 0 0xf1110000 0x10000>;
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 
 			/* RTC is provided by Seiko S-35390A below */
 			rtc at 10300 {
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index d67fafac495d..96adc87fdeba 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -72,7 +72,7 @@
 			reg = <MBUS_ID(0x01, 0x1d) 0 0x100000>;
 		};
 
-		internal-regs {
+		internal-regs at f0_01_0 {
 			sdramc at 1400 {
 				compatible = "marvell,armada-xp-sdram-controller";
 				reg = <0x1400 0x500>;
-- 
2.10.2
