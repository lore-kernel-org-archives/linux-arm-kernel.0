From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Nov 2016 00:05:04 +0100
Subject: [PATCH v3 15/19] ARM: dts: armada-370-xp: Fixup soc DT warning
In-Reply-To: <20161117230508.28539-1-gregory.clement@free-electrons.com>
References: <20161117230508.28539-1-gregory.clement@free-electrons.com>
Message-ID: <20161117230508.28539-16-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc has a ranges property so the unit name should contain an address.

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
index 6544be190550..32ce7d857e96 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -72,7 +72,11 @@
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index 712799b85031..8d8343990864 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -67,7 +67,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MiB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 94131595973f..044d73edb271 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -59,7 +59,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 9941a6fdf2f5..29dc08a23776 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -61,7 +61,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index d9203b79c3d3..59aab39fd273 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -61,7 +61,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index a5fc93b2da8d..7a849d6f136f 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -72,7 +72,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index 0d11e07c9c2e..7cad87cbd808 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -27,7 +27,11 @@
 	model = "Seagate NAS 4-Bay (Dart, SRPD40)";
 	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		/* The following unit address is composed of the target
 		 * value (bit [40-47]), attributes value (bits [32-39],
 		 * and the address value in the window memory: [0-31].
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 34b745325689..d2d3785d2a4b 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -28,7 +28,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
index c659a9085549..06b597596d03 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -26,7 +26,11 @@
 	model = "Seagate Personal Cloud 2-Bay (Cumulus, SRN22C)";
 	compatible = "seagate,cumulus-max", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		/* The following unit address is composed of the target
 		 * value (bit [40-47]), attributes value (bits [32-39],
 		 * and the address value in the window memory: [0-31].
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
index 175b6459745b..5109b0843de6 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -26,7 +26,11 @@
 	model = "Seagate Personal Cloud (Cumulus, SRN21C)";
 	compatible = "seagate,cumulus", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		/* The following unit address is composed of the target
 		 * value (bit [40-47]), attributes value (bits [32-39],
 		 * and the address value in the window memory: [0-31].
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index b00427d605ed..f7417e014f4c 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -29,7 +29,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index d0b0341c8fc8..4b0762ae5c64 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -75,7 +75,11 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 85d6b4b30014..a90f738c37e2 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -76,7 +76,11 @@
 		interrupts-extended = <&mpic 3>;
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index c07f584ab812..efe962819bcc 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -64,7 +64,11 @@
 		gpio2 = &gpio2;
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		compatible = "marvell,armada370-mbus", "simple-bus";
 
 		/* The following unit address is composed of the target
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index b3c7e236f492..7709a86913d8 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -67,7 +67,11 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x40000000>; /* 1GB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 0656ff44b563..bb57151b853f 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -72,7 +72,11 @@
 		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index eb935a230531..efd5ba8731d1 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -91,7 +91,11 @@
 		};
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc@f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 8904864848a4..f32cbadc3169 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -62,7 +62,11 @@
 		reg = <0 0x00000000 0 0x20000000>; /* 512MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 0aa5ef30a088..47bb3c8dff02 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -67,7 +67,11 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x10000000>; /* 256MB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 0b4a401c16ab..daace9af7fc1 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -65,7 +65,11 @@
 		reg = <0 0x00000000 0 0xf0000000>;
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 8fa9b73befa6..c54d248a263f 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -80,7 +80,11 @@
 		};
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		/*
 		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 		 * configured as x4 or quad x1 lanes. One unit is
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index 3eab76ef2448..ac761b0618d7 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -81,7 +81,11 @@
 		};
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		/*
 		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
 		 * configured as x4 or quad x1 lanes. One unit is
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 7fefd1fe1eef..4452813194d8 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -98,7 +98,11 @@
 		};
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc@f00100000000 {
 		/*
 		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
 		 * configured as x4 or quad x1 lanes. Two units are
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index 7a0e81d2ae68..6aeea5098ced 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -61,7 +61,11 @@
 		reg = <0 0x00000000 0 0x80000000>; /* 2GB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 468d850ff9b7..cd7ab44282e7 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -62,7 +62,11 @@
 		reg = <0 0x00000000 0 0x40000000>; /* 1 GB soldered on */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xe8000000 0x8000000
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index 89ab42010a6c..5765caf0cfef 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -75,7 +75,11 @@
 		reg = <0 0x00000000 0 0x40000000>; /* 1GB */
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc at f00100000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 68db324d6912..ba4fc7643bac 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -64,7 +64,11 @@
 		serial3 = &uart3;
 	};
 
-	soc {
+	/* The following unit address is composed of the target
+	 * value (bit [40-47]), attributes value (bits [32-39],
+	 * and the address value in the window memory: [0-31].
+	 */
+	soc@f00100000000 {
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 
 		/* The following unit address is composed of the target
-- 
2.10.2
