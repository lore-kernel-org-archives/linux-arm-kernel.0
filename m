From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun, 13 Nov 2016 22:23:58 +0100
Subject: [PATCH v2 15/19] ARM: dts: armada-370-xp: Fixup soc DT warning
In-Reply-To: <20161113212402.3060-1-gregory.clement@free-electrons.com>
References: <20161113212402.3060-1-gregory.clement@free-electrons.com>
Message-ID: <20161113212402.3060-16-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

soc has a ranges property so the unit name should contain an address.

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
index 6ab09c846211..65f348113c58 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -72,7 +72,7 @@
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index ee114f920494..b8339f3c43eb 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -67,7 +67,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MiB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 3ee6228c1dd6..b64e02aa88ea 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -59,7 +59,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 6b2437fa8e84..791264b44d98 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -61,7 +61,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 2ed97b8ae686..19e16c650f1a 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -61,7 +61,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index f2535794d35b..80ee06f542c2 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -72,7 +72,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index 61a3576ca090..2e98772d1ee3 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -27,7 +27,7 @@
 	model = "Seagate NAS 4-Bay (Dart, SRPD40)";
 	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	soc at f0_01_0 {
 		internal-regs at f0_01_0 {
 			ethernet at 74000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 64a1ccfda42b..c1bea2ef8eca 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -28,7 +28,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
index 0ba79c0cf379..e469c55a4c13 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -26,7 +26,7 @@
 	model = "Seagate Personal Cloud 2-Bay (Cumulus, SRN22C)";
 	compatible = "seagate,cumulus-max", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	soc at f0_01_0 {
 		internal-regs at f0_01_0 {
 			sata at a0000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
index 1766f74ffa7d..0763debbed75 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -26,7 +26,7 @@
 	model = "Seagate Personal Cloud (Cumulus, SRN21C)";
 	compatible = "seagate,cumulus", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	soc at f0_01_0 {
 		internal-regs at f0_01_0 {
 			sata at a0000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 0b25f1dac938..779cffdaa561 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -29,7 +29,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index f4b6f5fca85c..00b14b6a3884 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -75,7 +75,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 5505b14c2ac4..ef4f26a8e712 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -76,7 +76,7 @@
 		interrupts-extended = <&mpic 3>;
 	};
 
-	soc {
+	soc at f0_01_0 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 9b73bd924424..e5d543692469 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -64,7 +64,7 @@
 		gpio2 = &gpio2;
 	};
 
-	soc {
+	soc at f0_01_0 {
 		compatible = "marvell,armada370-mbus", "simple-bus";
 
 		bootrom at 01_e0_0 {
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 9c569796301b..ba59b373ff2c 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -67,7 +67,7 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x40000000>; /* 1GB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 3dd6756e86af..99eb8a022599 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -72,7 +72,7 @@
 		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index a5469e23dd85..31b218b5c975 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -91,7 +91,7 @@
 		};
 	};
 
-	soc {
+	soc@f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index a1343f9cbb0e..1debbb2e12a8 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -62,7 +62,7 @@
 		reg = <0 0x00000000 0 0x20000000>; /* 512MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 738e5d5b9d1a..10c80c824311 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -67,7 +67,7 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x10000000>; /* 256MB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 7a5c9d1a2caa..9bcc0d03f49d 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -65,7 +65,7 @@
 		reg = <0 0x00000000 0 0xf0000000>;
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 64a80419e284..f93593c1111e 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -80,7 +80,7 @@
 		};
 	};
 
-	soc {
+	soc at f0_01_0 {
 		/*
 		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 		 * configured as x4 or quad x1 lanes. One unit is
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index acdd9152c232..a3f4f7213711 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -81,7 +81,7 @@
 		};
 	};
 
-	soc {
+	soc at f0_01_0 {
 		/*
 		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
 		 * configured as x4 or quad x1 lanes. One unit is
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 53982474344f..3b6c87bc19b1 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -98,7 +98,7 @@
 		};
 	};
 
-	soc {
+	soc@f0_01_0 {
 		/*
 		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
 		 * configured as x4 or quad x1 lanes. Two units are
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index e6e009dda98f..df78911e63b6 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -61,7 +61,7 @@
 		reg = <0 0x00000000 0 0x80000000>; /* 2GB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 308e2547d46e..4cfce329ad47 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -62,7 +62,7 @@
 		reg = <0 0x00000000 0 0x40000000>; /* 1 GB soldered on */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xe8000000 0x8000000
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index fb553d462b5a..0c8491cfeb7d 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -75,7 +75,7 @@
 		reg = <0 0x00000000 0 0x40000000>; /* 1GB */
 	};
 
-	soc {
+	soc at f0_01_0 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 96adc87fdeba..333b743f8fe7 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -64,7 +64,7 @@
 		serial3 = &uart3;
 	};
 
-	soc {
+	soc at f0_01_0 {
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 
 		bootrom@01_1d_0 {
-- 
2.10.2
