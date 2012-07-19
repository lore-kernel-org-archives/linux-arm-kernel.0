From: jm@lentin.co.uk (Jamie Lentin)
Date: Thu, 19 Jul 2012 21:30:59 +0100
Subject: [PATCH 3/4] ARM: Kirkwood: Move common portions into a
 kirkwood-dnskw.dtsi
In-Reply-To: <1342729860-14647-1-git-send-email-jm@lentin.co.uk>
References: <y>
 <1342729860-14647-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1342729860-14647-4-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A lot of device setup is shared between DNS-320 and DNS-325, move the
definitions into a common include.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/kirkwood-dns320.dts |   42 +----------------------------
 arch/arm/boot/dts/kirkwood-dns325.dts |   42 +----------------------------
 arch/arm/boot/dts/kirkwood-dnskw.dtsi |   48 +++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 82 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dnskw.dtsi

diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index a81c3a9..d41e204 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
+/include/ "kirkwood-dnskw.dtsi"
 
 / {
 	model = "D-Link DNS-320 NAS (Rev A1)";
@@ -50,45 +50,5 @@
 			clock-frequency = <166666667>;
 			status = "okay";
 		};
-
-		sata at 80000 {
-			status = "okay";
-			nr-ports = <2>;
-		};
-
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x500000>;
-			};
-
-			partition at 600000 {
-				label = "ramdisk";
-				reg = <0x0600000 0x500000>;
-			};
-
-			partition at b00000 {
-				label = "image";
-				reg = <0x0b00000 0x6600000>;
-			};
-
-			partition at 7100000 {
-				label = "mini firmware";
-				reg = <0x7100000 0xa00000>;
-			};
-
-			partition at 7b00000 {
-				label = "config";
-				reg = <0x7b00000 0x500000>;
-			};
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index 421dcab..2662efc 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
+/include/ "kirkwood-dnskw.dtsi"
 
 / {
 	model = "D-Link DNS-325 NAS (Rev A1)";
@@ -53,45 +53,5 @@
 			clock-frequency = <200000000>;
 			status = "okay";
 		};
-
-		sata at 80000 {
-			status = "okay";
-			nr-ports = <2>;
-		};
-
-		nand at 3000000 {
-			status = "okay";
-
-			partition at 0 {
-				label = "u-boot";
-				reg = <0x0000000 0x100000>;
-				read-only;
-			};
-
-			partition at 100000 {
-				label = "uImage";
-				reg = <0x0100000 0x500000>;
-			};
-
-			partition at 600000 {
-				label = "ramdisk";
-				reg = <0x0600000 0x500000>;
-			};
-
-			partition at b00000 {
-				label = "image";
-				reg = <0x0b00000 0x6600000>;
-			};
-
-			partition at 7100000 {
-				label = "mini firmware";
-				reg = <0x7100000 0xa00000>;
-			};
-
-			partition at 7b00000 {
-				label = "config";
-				reg = <0x7b00000 0x500000>;
-			};
-		};
 	};
 };
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
new file mode 100644
index 0000000..067672c
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -0,0 +1,48 @@
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "D-Link DNS NASes (kirkwood-based)";
+	compatible = "dlink,dns-kirkwood", "mrvl,kirkwood-88f6281", "mrvl,kirkwood";
+
+	ocp at f1000000 {
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+		nand at 3000000 {
+			status = "okay";
+
+			partition at 0 {
+				label = "u-boot";
+				reg = <0x0000000 0x100000>;
+				read-only;
+			};
+
+			partition at 100000 {
+				label = "uImage";
+				reg = <0x0100000 0x500000>;
+			};
+
+			partition at 600000 {
+				label = "ramdisk";
+				reg = <0x0600000 0x500000>;
+			};
+
+			partition at b00000 {
+				label = "image";
+				reg = <0x0b00000 0x6600000>;
+			};
+
+			partition at 7100000 {
+				label = "mini firmware";
+				reg = <0x7100000 0xa00000>;
+			};
+
+			partition at 7b00000 {
+				label = "config";
+				reg = <0x7b00000 0x500000>;
+			};
+		};
+	};
+};
-- 
1.7.10.4
