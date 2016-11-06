From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sun,  6 Nov 2016 23:27:08 +0100
Subject: [PATCH 15/19] ARM: dts: armada-370-xp: Fixup soc DT warning
In-Reply-To: <20161106222712.27366-1-gregory.clement@free-electrons.com>
References: <20161106222712.27366-1-gregory.clement@free-electrons.com>
Message-ID: <20161106222712.27366-16-gregory.clement@free-electrons.com>
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
index 729bc1f95948..6cfd827272bb 100644
--- a/arch/arm/boot/dts/armada-370-db.dts
+++ b/arch/arm/boot/dts/armada-370-db.dts
@@ -72,7 +72,7 @@
 		reg = <0x00000000 0x40000000>; /* 1 GB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index fd5bfd38524e..42d2b1077d42 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -67,7 +67,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MiB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
index 2d15d2c44575..e2880bed9339 100644
--- a/arch/arm/boot/dts/armada-370-mirabox.dts
+++ b/arch/arm/boot/dts/armada-370-mirabox.dts
@@ -59,7 +59,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index 1a6998e28780..39c00013ac61 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -61,7 +61,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
index 9ced0f5842fe..741a9be59a8a 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
@@ -61,7 +61,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
index 72c919c6c963..cb016f43789e 100644
--- a/arch/arm/boot/dts/armada-370-rd.dts
+++ b/arch/arm/boot/dts/armada-370-rd.dts
@@ -72,7 +72,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index 24aa7e525131..c625284a28f4 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -27,7 +27,7 @@
 	model = "Seagate NAS 4-Bay (Dart, SRPD40)";
 	compatible = "seagate,dart-4", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	soc at f1000000 {
 		internal-regs at f1000000 {
 			ethernet at 74000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index b951b8e574c6..58a9455e978e 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -28,7 +28,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
index a7c1595f0af9..74fc268f2975 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud-2bay.dts
@@ -26,7 +26,7 @@
 	model = "Seagate Personal Cloud 2-Bay (Cumulus, SRN22C)";
 	compatible = "seagate,cumulus-max", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	soc at f1000000 {
 		internal-regs at f1000000 {
 			sata at a0000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
index 127563ac31db..3d60864c3f23 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dts
@@ -26,7 +26,7 @@
 	model = "Seagate Personal Cloud (Cumulus, SRN21C)";
 	compatible = "seagate,cumulus", "marvell,armada370", "marvell,armada-370-xp";
 
-	soc {
+	soc at f1000000 {
 		internal-regs at f1000000 {
 			sata at a0000 {
 				status = "okay";
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index a4c4503648bc..7c0252a830a2 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -29,7 +29,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000>;
 
diff --git a/arch/arm/boot/dts/armada-370-synology-ds213j.dts b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
index 9948309630d4..4e71a3524ed4 100644
--- a/arch/arm/boot/dts/armada-370-synology-ds213j.dts
+++ b/arch/arm/boot/dts/armada-370-synology-ds213j.dts
@@ -75,7 +75,7 @@
 		reg = <0x00000000 0x20000000>; /* 512 MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0xe0) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x01) 0 0xf1100000 0x10000>;
diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 0814c1878b39..df7c3e38e0fc 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -76,7 +76,7 @@
 		interrupts-extended = <&mpic 3>;
 	};
 
-	soc {
+	soc at f1000000 {
 		#address-cells = <2>;
 		#size-cells = <1>;
 		controller = <&mbusc>;
diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index f6c12574ff3f..f7ea2df18a86 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -64,7 +64,7 @@
 		gpio2 = &gpio2;
 	};
 
-	soc {
+	soc at f1000000 {
 		compatible = "marvell,armada370-mbus", "simple-bus";
 
 		bootrom at 0 {
diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
index 062a32cc4a5f..aa9974e3e72d 100644
--- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
+++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
@@ -67,7 +67,7 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x40000000>; /* 1GB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
index 8428624633b8..697784557931 100644
--- a/arch/arm/boot/dts/armada-xp-db.dts
+++ b/arch/arm/boot/dts/armada-xp-db.dts
@@ -72,7 +72,7 @@
 		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
index 12d18c9d9f0c..3fcae0e47d9c 100644
--- a/arch/arm/boot/dts/armada-xp-gp.dts
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -91,7 +91,7 @@
 		};
 	};
 
-	soc {
+	soc@f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000
diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
index 50feb6bc748f..33dcb56486f1 100644
--- a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
+++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
@@ -62,7 +62,7 @@
 		reg = <0 0x00000000 0 0x20000000>; /* 512MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 5a49b9c6a2f5..ce86ceab9289 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -67,7 +67,7 @@
 		reg = <0x00000000 0x00000000 0x00000000 0x10000000>; /* 256MB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
index 8b34db8a9f45..e202890780c2 100644
--- a/arch/arm/boot/dts/armada-xp-matrix.dts
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -65,7 +65,7 @@
 		reg = <0 0x00000000 0 0xf0000000>;
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 8be43d42a1ef..82977a91cb5f 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -80,7 +80,7 @@
 		};
 	};
 
-	soc {
+	soc at f1000000 {
 		/*
 		 * MV78230 has 2 PCIe units Gen2.0: One unit can be
 		 * configured as x4 or quad x1 lanes. One unit is
diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
index b01b8f7e1f47..8057516ca3de 100644
--- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
@@ -81,7 +81,7 @@
 		};
 	};
 
-	soc {
+	soc at f1000000 {
 		/*
 		 * MV78260 has 3 PCIe units Gen2.0: Two units can be
 		 * configured as x4 or quad x1 lanes. One unit is
diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
index 665fe9edda98..8314b197d88f 100644
--- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
@@ -98,7 +98,7 @@
 		};
 	};
 
-	soc {
+	soc@f1000000 {
 		/*
 		 * MV78460 has 4 PCIe units Gen2.0: Two units can be
 		 * configured as x4 or quad x1 lanes. Two units are
diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
index f6a5e9f45d28..df7e196bbc37 100644
--- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
+++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
@@ -61,7 +61,7 @@
 		reg = <0 0x00000000 0 0x80000000>; /* 2GB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
index 2c4f79303e6b..3d1c533605ce 100644
--- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -62,7 +62,7 @@
 		reg = <0 0x00000000 0 0x40000000>; /* 1 GB soldered on */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x01, 0x2f) 0 0 0xe8000000 0x8000000
diff --git a/arch/arm/boot/dts/armada-xp-synology-ds414.dts b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
index bbbaf64189de..43e501f2c307 100644
--- a/arch/arm/boot/dts/armada-xp-synology-ds414.dts
+++ b/arch/arm/boot/dts/armada-xp-synology-ds414.dts
@@ -75,7 +75,7 @@
 		reg = <0 0x00000000 0 0x40000000>; /* 1GB */
 	};
 
-	soc {
+	soc at f1000000 {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x09) 0 0 0xf1100000 0x10000
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index daa7220fc669..f17f56f6eeff 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -64,7 +64,7 @@
 		serial3 = &uart3;
 	};
 
-	soc {
+	soc at f1000000 {
 		compatible = "marvell,armadaxp-mbus", "simple-bus";
 
 		bootrom@0 {
-- 
2.10.1
